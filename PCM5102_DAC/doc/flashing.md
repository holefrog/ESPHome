**Mode**: NODEMCU ESP32

# Enable flash
1. Usually, the USB-to-UART adapter on the board can control these pins, so you don't have to do it manually.
2. If can not connect:
Press and hold BOOT, then press and release EN.


# Port
/dev/ttyUSB0 is the port of the USB adaper on Linux. You can find what port is used by the adapter by running dmesg after plugging in the USB device. 


# Check port
````
sudo putty /dev/ttyUSB0 -serial -sercfg 115200,8,n,1,N 
```


# Flash new ESPHome firmware
```
esphome run esp32.yaml
```
```
INFO Successfully compiled program.
Found multiple options, please choose one:
  [1] /dev/ttyUSB0 (CP2102 USB to UART Bridge Controller - CP2102 USB to UART Bridge Controller)
  [2] Over The Air (esp32.local)
(number): 1
esptool.py v4.4
Serial port /dev/ttyUSB0
Connecting.......
Chip is ESP32-D0WD-V3 (revision v3.0)
Features: WiFi, BT, Dual Core, 240MHz, VRef calibration in efuse, Coding Scheme None
Crystal is 40MHz
MAC: cc:db:a7:16:1a:30
Uploading stub...
Running stub...

```



# Upload firmware
```
esphome upload esp32.yaml --device /dev/ttyUSB0
esphome upload esp32.yaml --device 192.168.50.x
```


# If cannot run esphome
```
david@Home-X230:~/Documents/HomeAssistant/esphome_x86/esp32/1.0$ esphome
bash: esphome: command not found
```

try:
```
david@Home-X230:~/Documents/HomeAssistant/esphome_x86/esp32/1.0$ source ~/.profile 
david@Home-X230:~/Documents/HomeAssistant/esphome_x86/esp32/1.0$ esphome run esp32.yaml 
INFO Reading configuration esp32.yaml...
INFO Generating C++ source...
INFO Compiling app...
Processing esp32 (boa
```
