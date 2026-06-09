# 刷机指南

参考链接: [https://github.com/mmakaay/esphome-xiaomi_bslamp2/blob/dev/doc/flashing.md#solder-wires-to-the-board]


## 1. 连接方法
引脚/焊点 <--> USB 转串口模块
- GND   <--> GND
- TX    <--> RX
- RX    <--> TX (需 3.3V 逻辑电平)
- GPIO0 <--> GND (仅在启动时临时接地)


## 2. 串口说明
在 Linux 系统中，USB 串口模块通常显示为 `/dev/ttyUSB0`。
插入 USB 设备后，可以通过运行 `dmesg` 命令来查找实际的端口号。


## 3. 查看串口 (TTL)
1. 连接后运行：
```bash
sudo putty /dev/ttyUSB0 -serial -sercfg 115200,8,n,1,N 
```
2. 接通台灯电源启动台灯，并查看日志输出。


## 4. 进入刷机模式 (Flash Mode)
为了能够刷写台灯，在台灯启动时必须将 GPIO0 连接到 GND。

1. 将 USB 串口模块连接到电脑。
特别注意 TX/RX 的交叉连接（TX 接 RX，反之亦然）。
2. 打开 esphome-flasher 工具，选择使用的 COM 端口，然后点击 "View logs" (查看日志)。
3. 将 "GPIO0" 连接到 "GND"。
4. 插入台灯电源供电，启动台灯。
5. 启动后，台灯即进入刷机模式，此时可以断开 "GPIO0" 与 "GND" 的连接。


## 5. 备份当前（原厂）固件
### 下载 esptool [https://github.com/espressif/esptool]
1. 进入刷机模式。
2. 然后运行 esptool `read_flash` 命令：

```bash
python3 esptool.py -p /dev/ttyUSB0 read_flash 0x0 0x400000 original-firmware.bin
```


## 6. 还原备份的固件
1. 进入刷机模式。
2. 然后运行 esptool `write_flash` 命令：
```bash
python3 esptool.py --chip esp32 --port /dev/ttyUSB0 --baud 115200 write_flash 0x00 original-firmware.bin
```

示例输出：
```text
python3 esptool.py -p /dev/ttyUSB0 read_flash 0x0 0x400000 original-firmware.bin
esptool.py v4.5-dev
Serial port /dev/ttyUSB0
Connecting.....
Detecting chip type... Unsupported detection protocol, switching and trying again...
Connecting...
Detecting chip type... ESP32
Chip is unknown ESP32 (revision v1.0)
Features: WiFi, BT, Single Core, 240MHz, VRef calibration in efuse, Coding Scheme 3/4
Crystal is 40MHz
MAC: 40:31:3c:b0:78:3f
Uploading stub...
Running stub...
Stub running...
4194304 (100 %)
4194304 (100 %)
Read 4194304 bytes at 0x00000000 in 394.5 seconds (85.1 kbit/s)...
Hard resetting via RTS pin...
```

## 7. 刷写新的 ESPHome 固件

### 使用 esphome 命令 [推荐，工作良好]
1. 进入刷机模式。
2. 然后运行 esphome `run` 命令：
```bash
esphome run device.yaml
```
3. 刷机完成后
断开台灯电源，将 GPIO0 与 GND 断开连接，然后重新接通电源以启动新的 ESPHome 固件。



