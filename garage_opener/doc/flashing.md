Flash Guide
[https://www.youtube.com/watch?v=AU1KD_aJSMY&list=LL&index=21]



# Connection
Soldering point <-->	Serial USB Adapter name
GND 	GND
TX 	    RX
RX 	    TX
Vcc     Vcc  (3.3V)



# Port
/dev/ttyUSB0 is the port of the USB adaper on Linux. 
You can find what port is used by the adapter by running dmesg after plugging in the USB device. 



# Check port
1. connect  
````
sudo putty /dev/ttyUSB0 -serial -sercfg 115200,8,n,1,N 
```


# Enter flash mode
1. connect the PCB (GND, RX and TX) to USB adapter to you computer. 

2. connect the USB adapter to you computer. 

3. press button on the PCB and plug the Vcc from adapter to the PCB.

After booting, the switch in flash mode, release the button

The light on PCB will not light on in flash mode


# Make a backup of the current firmware
## Download esptool [https://github.com/espressif/esptool]
1. Enter flash mode
2. then start the esptool read_flash command:

```
cd esptool-master
python3 esptool.py -p /dev/ttyUSB0 read_flash 0x0 0x400000 original-firmware.bin
```


```
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

# Restore the backed up firmware
1. Enter flash mode
2. then start the esptool write_flash command:
```
cd esptool-master
python3 esptool.py --chip esp32 --port COM3 --baud 115200 write_flash 0x00 original-firmware.bin
```




# Flash new ESPHome firmware
## By esphome [Works well]
1. Enter flash mode


2. then start the esphome run command:
```
esphome run device.yaml
```

```
Building .pioenvs/garage/firmware.bin
esp8266_copy_factory_bin([".pioenvs/garage/firmware.bin"], [".pioenvs/garage/firmware.elf"])
============================================================ [SUCCESS] Took 90.04 seconds ============================================================
INFO Successfully compiled program.
Found multiple options, please choose one:
  [1] /dev/ttyUSB0 (FT232R USB UART - FT232R USB UART)
  [2] Over The Air (garage.local)
(number): 1
esptool.py v4.4
Serial port /dev/ttyUSB0
Connecting...
Chip is ESP8266EX
Features: WiFi
Crystal is 26MHz
MAC: e8:db:84:9f:0b:77
Stub is already running. No upload is necessary.
Changing baud rate to 460800
Changed.
Configuring flash size...
Auto-detected Flash size: 1MB
Flash will be erased from 0x00000000 to 0x0005cfff...
Compressed 378080 bytes to 264200...
Wrote 378080 bytes (264200 compressed) at 0x00000000 in 24.7 seconds (effective 122.6 kbit/s)...
Hash of data verified.

Leaving...
Hard resetting via RTS pin...
INFO Successfully uploaded program.
INFO Starting log output from /dev/ttyUSB0 with baud rate 115200

```


3. After flashing
Disconnect and reconnect the power to boot into the new ESPHome firmware.


