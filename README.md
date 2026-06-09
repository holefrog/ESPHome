# ESPHome 设备

本仓库包含用于各种自定义和修改版智能家居设备的 ESPHome 配置文件。

## 📦 设备列表

### 1. 背光画框 (`backlit_frame`)
基于 ESP8266 (ESP-01 1M) 的自定义控制器。
- **硬件**: ESP-01 1M, PIR 人体传感器 (GPIO3), 灯带/继电器 (GPIO0).
- **功能**: 当 PIR 传感器检测到人体移动时，自动打开灯，并在配置的延迟时间（默认 60 秒）内保持常亮。 
- **相关资源**: 刷机指南、接线图和引脚定义请参阅 `backlit_frame/doc/`。

### 2. 床头灯 (`bedside_lamp`)
用于小米米家床头灯 2 的自定义 ESPHome 固件。
- **功能**: 将小米床头灯 2 完全本地化接入 Home Assistant，支持 OTA 状态反馈、默认行为配置以及预设激活服务。
- **配置说明**: 该设备的配置文件通过 ESPHome 的 `packages` 功能，引用了 Github 上的 `mmakaay/esphome-xiaomi_bslamp2` 核心代码。因此你会看到 `bedside-lamp.yaml` 看起来像一个“空壳”，实际上它的完整配置是在编译时从云端和本地包拉取的，这是该项目推荐的配置方式。
- **相关资源**: 拆机、焊接和刷机指南请参阅 `bedside_lamp/doc/`。

## 📂 项目结构

```text
ESPHome/
├── common/                  # 共享的配置片段
│   └── wifi_fallback.yaml   # 备用 AP 配置
├── backlit_frame/           
│   ├── config/              # ESPHome yaml 配置文件
│   └── doc/                 # 图片、引脚和刷机指南
├── bedside_lamp/
│   ├── config/              # ESPHome yaml 配置文件
│   └── doc/                 # 硬件拆解和刷机指南
├── secrets.yaml             # 全局隐私配置文件 (被 Git 忽略)
└── README.md                # 本文件
```

## ⚙️ 设置与编译

### 安装 ESPHome CLI
如果你需要在本地主机上编译固件并刷机，需要先安装 ESPHome。
推荐在项目目录中使用 Python 虚拟环境（`venv`）。本项目提供了一个自动化的环境配置脚本 `init_workspace.sh`，它会自动安装系统依赖、创建 Python 虚拟环境并安装 ESPHome 及所需依赖，同时还会配置 USB 硬件刷机权限：

```bash
# 运行工作区初始化脚本
./init_workspace.sh
```

*(注意：脚本运行后可能会提示需要重新登录，以使 USB 权限生效)*

之后每次打开新的终端并使用 `esphome` 前，需要先在仓库根目录运行以下命令以激活虚拟环境：
```bash
source .venv/bin/activate
```
*(注意：也可以使用 Docker 或 `pipx` 进行安装)*


### Secrets 隐私管理
为了避免在各个配置文件中重复填写敏感信息（如 WiFi 密码和 API 密钥），并确保它们不会被意外提交到 Git，本项目在根目录下使用了一个集中的 `secrets.yaml` 文件。

1. **创建全局 secrets 文件:**
   在仓库根目录下创建一个 `secrets.yaml` 文件：
   ```yaml
   wifi_ssid: "your_wifi_ssid"
   wifi_password: "your_wifi_password"
   api_encryption_key: "your_api_encryption_key"
   api_password: "your_api_password"
   ota_password: "your_ota_password"
   ```

2. **将 secrets 链接到设备配置目录:**
   因为 ESPHome 编译时会在设备主配置文件所在的目录寻找 `secrets.yaml`，所以你需要在每个设备的 `config` 文件夹中创建指向根目录 `secrets.yaml` 的软链接。
   
   在仓库根目录下运行以下命令：
   ```bash
   ln -sf ../../secrets.yaml backlit_frame/config/secrets.yaml
   ln -sf ../../secrets.yaml bedside_lamp/config/secrets.yaml
   ```
   *注意: Git 的 `.gitignore` 文件中已经包含了 `secrets*`，这会阻止这些文件或软链接被 Git 追踪。*

### 编译和刷机 (首次 USB 刷入)
对于全新设备，首次刷机需要通过 USB 串口连接电脑：

1. **基本命令示例**：
```bash
# 编译并选择 USB 端口刷入背光画框
esphome run backlit_frame/config/backlit_frame.yaml --device /dev/ttyUSB0

# 编译并选择 USB 端口刷入床头灯
esphome run bedside_lamp/config/bedside-lamp.yaml
```

2. **Verify yaml**
```bash
yamllint esp32-cam.yaml
```

3. **Enter flash mode, then start the esphome run command:**
```bash
esphome run esp32-cam.yaml --device 192.168.50.144

esphome upload esp32-cam.yaml --device 192.168.50.144

esphome logs esp32-cam.yaml --device 192.168.50.144
```

### 无线 OTA 升级 (Over-The-Air)
当设备首次刷入固件并成功连接到 Wi-Fi 后，后续的任何配置修改和固件升级都可以直接通过无线网络 (OTA) 完成，无需再连接 USB 线。

只需像往常一样运行 `run` 命令：
```bash
esphome run backlit_frame/config/backlit_frame.yaml
```
ESPHome 会自动编译固件，并在询问刷机方式时，自动检测到局域网内的设备（或者你直接选择网络/OTA 选项）。

如果自动发现失败，或者你想明确指定目标设备，可以加上设备 IP：
```bash
esphome run backlit_frame/config/backlit_frame.yaml --device 192.168.1.50
```
将 `192.168.1.50` 替换为实际设备 IP。只要你的 `secrets.yaml` 中配置的 `ota_password` 正确，固件就会通过 Wi-Fi 推送到设备中。
