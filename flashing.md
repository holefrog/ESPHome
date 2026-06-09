# ESPHome 通用刷机指南

本文档总结了不同 ESPHome 项目（如 Backlit Frame 和 Bedside Lamp）的通用刷机步骤。

## 1. 连接方法
将设备的焊点或引脚连接到 USB 转串口模块 (Serial USB Adapter)：
- **GND** <--> **GND**
- **TX**  <--> **RX**
- **RX**  <--> **TX** (注意需要 3.3V 逻辑电平)
- **Vcc** <--> **Vcc** (按需要，一般不接。如果设备没供电再接。)



> **串口号说明**:
> 在 Linux 系统下，USB 转串口模块通常被识别为 `/dev/ttyUSB0`。插入 USB 设备后，可以通过运行 `dmesg` 命令来查找实际分配的端口号。

## 2. 查看 TTL 方法
连接好串口后，可以使用终端工具查看设备的开机及串口日志输出：
```bash
sudo putty /dev/ttyUSB0 -serial -sercfg 115200,8,n,1,N 
```
或者使用 `picocom` 工具：
```bash
sudo picocom -b 115200 /dev/ttyUSB0
```

## 3. 进入 Flash 方法
为了能够向设备刷写固件，设备在启动（上电）时必须将 **GPIO0 (或 IO0)** 引脚连接到 **GND**。
通用步骤如下：
1. 将设备的 **GPIO0** (或 **IO0**) 连接到 **GND**。
2. 将 USB 转串口模块连接到电脑（请注意 TX 和 RX 必须交叉连接）。
3. 给设备上电启动（供电方式视具体设备而定，见下方项目特殊说明）。
4. 设备上电后即进入 Flash 刷机模式。此时可以将 GPIO0 与 GND 断开（部分设备要求保持连接直到刷机完成）。

## 4. 刷机方法
确认设备已进入 Flash 模式后，可以使用 `esphome` 命令行工具上传固件：
```bash
# 运行并编译上传
esphome run <your_device.yaml>

# 或者指定设备/端口上传
esphome upload <your_device.yaml> --device /dev/ttyUSB0
```
> **提示**: 如果在 Linux 下提示串口权限不足，请先将当前用户加入 `dialout` 用户组并重新登录：
> ```bash
> sudo usermod -a -G dialout $USER
> ```

**刷机完成后的操作**:
拔下适配器或断开设备的电源，确保 **GPIO0** 已经与 **GND** 断开连接，然后重新上电，设备将启动进入全新的 ESPHome 固件。

---

## 5. 项目差异与特殊说明 (Project Specifics)

### Backlit Frame (ESP8266-01S)
- **供电连接**: 刷机时可以直接使用 USB 模块供电，将模块的 **Vcc (3.3V)** 连接到 ESP-01S 的 **Vcc**。
- **进入 Flash**: 将 `IO0` 连接到 `GND`，把接好线的 USB 模块插入电脑即可进入 Flash 模式。
- **OTA 刷机**: 此设备支持通过 IP 地址进行 OTA 固件上传，例如：
  ```bash
  esphome upload 8266-01s.yaml --device 192.168.50.54
  ```
- **参考资料**: [ESPHome for ESP8266-01S](https://www.emcu-homeautomation.org/esphome-for-drive-eps8266-01s-or-eps8266-01-in-home-assistant/)

### Bedside Lamp Mi (米家床头灯)
- **供电连接**: 刷机时 **不要** 使用 USB 模块为台灯供电，而是**插入台灯自带的电源适配器**来开机启动。
- **查看日志特殊操作**: 插入台灯电源启动的同时，通过 putty 或 esphome-flasher 监听串口以查看开机日志。
- **进入 Flash 特殊步骤**: 
  1. 打开 esphome-flasher 工具，选择对应的 COM 端口并点击 "View logs"。
  2. 短接 `GPIO0` 到 `GND`。
  3. 插入台灯自带的电源供电启动。
  4. 启动进入 Flash 模式后，松开/断开 `GPIO0` 与 `GND`。
- **固件备份与还原 (esptool)**:
  此项目强烈建议备份原厂固件。
  - **备份原始固件**: 
    进入 Flash 模式后，使用 esptool 读取固件：
    ```bash
    python3 esptool.py -p /dev/ttyUSB0 read_flash 0x0 0x400000 original-firmware.bin
    ```
  - **还原原始固件**:
    ```bash
    python3 esptool.py --chip esp32 --port /dev/ttyUSB0 --baud 115200 write_flash 0x00 original-firmware.bin
    ```
- **其他刷机方式**:
  除了 `esphome run`，该项目还介绍了通过 `esphome-flasher` 界面工具以及直接使用 `esptool.py` 写入分区文件 (`bootloader`, `partitions`, `firmware` 等) 的命令行刷机方式。
- **参考资料**: [esphome-xiaomi_bslamp2 flashing guide](https://github.com/mmakaay/esphome-xiaomi_bslamp2/blob/dev/doc/flashing.md#solder-wires-to-the-board)