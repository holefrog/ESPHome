刷机指南
[https://www.youtube.com/watch?v=AU1KD_aJSMY&list=LL&index=21]



# 连接
焊接点 <-->	串口 USB 适配器名称
GND 	GND
TX 	    RX
RX 	    TX
Vcc     Vcc  (3.3V)



# 端口
在 Linux 系统上，/dev/ttyUSB0 是 USB 适配器的端口。
你可以在插入 USB 设备后运行 dmesg 命令来查找适配器使用的端口。



# 检查端口
1. 连接
````
sudo putty /dev/ttyUSB0 -serial -sercfg 115200,8,n,1,N 
```


# 进入刷机模式
1. 将 PCB（GND、RX 和 TX）连接到 USB 适配器，然后再连接到你的电脑。

2. 将 USB 适配器连接到你的电脑。

3. 按住 PCB 上的按钮，并将适配器的 Vcc 插入 PCB。

启动后，开关进入刷机模式，松开按钮。

刷机模式下，PCB 上的指示灯不会亮起。


# 备份当前固件
## 下载 esptool [https://github.com/espressif/esptool]
1. 进入刷机模式
2. 然后启动 esptool read_flash 命令：

```
cd esptool-master
python3 esptool.py -p /dev/ttyUSB0 read_flash 0x0 0x400000 original-firmware.bin
```

# 恢复备份的固件
1. 进入刷机模式
2. 然后启动 esptool write_flash 命令：
```
cd esptool-master
python3 esptool.py --chip esp32 --port COM3 --baud 115200 write_flash 0x00 original-firmware.bin
```




# 刷入新的 ESPHome 固件
## 通过 esphome [工作正常]
1. 进入刷机模式


2. 然后启动 esphome 刷机命令：
```
esphome run garage.yaml
# 或者指定 IP 上传
esphome upload garage.yaml --device 192.168.50.221
```


3. 刷机后
断开并重新连接电源，以启动进入新的 ESPHome 固件。
