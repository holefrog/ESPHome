# 刷机指南

参考链接: [https://www.emcu-homeautomation.org/esphome-for-drive-eps8266-01s-or-eps8266-01-in-home-assistant/]

YAML 配置参考:
[https://www.esphome-devices.com/devices/ESP-01S-1-channel-relay]


## 1. 连接方法
引脚/焊点 <--> USB 转串口模块
- GND   <--> GND
- TX    <--> RX
- RX    <--> TX
- Vcc   <--> Vcc (3.3V)
- GIO0  <--> 接地 (GND)


## 2. 串口说明
在 Linux 系统中，USB 串口模块通常显示为 `/dev/ttyUSB0`。
插入 USB 设备后，可以通过运行 `dmesg` 命令来查找实际分配的端口号。


## 3. 查看串口 (TTL)
连接后运行：
```bash
sudo putty /dev/ttyUSB0 -serial -sercfg 115200,8,n,1,N 
```
或者使用 picocom：
```bash
sudo picocom -b 115200 /dev/ttyUSB0
```


## 4. 进入刷机模式 (Flash Mode)
0. 将 IO0 引脚连接到 GND 引脚。
1. 将 PCB（GND、RX 和 TX）连接到 USB 串口模块。
2. 将 USB 串口模块插入电脑。


## 5. 刷机后的操作
拔下 USB 串口模块。
断开 IO0 与 GND 的连接。


## 6. 将用户添加到 dialout 组 (解决权限问题)
```bash
sudo usermod -a -G dialout david
```


## 7. 上传固件
```bash
esphome upload 8266-01s.yaml --device /dev/ttyUSB0
esphome upload 8266-01s.yaml --device 192.168.50.54
```
