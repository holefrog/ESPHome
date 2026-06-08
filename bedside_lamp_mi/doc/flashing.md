Flash Guide
[https://github.com/mmakaay/esphome-xiaomi_bslamp2/blob/dev/doc/flashing.md#solder-wires-to-the-board]


# Connection
Soldering point <-->	Serial USB Adapter name
GND 	GND
TX 	    RX
RX 	    TX (3.3V)
GPIO0 	GND (temporaryly when boot)


# Port
/dev/ttyUSB0 is the port of the USB adaper on Linux. You can find what port is used by the adapter by running dmesg after plugging in the USB device. 


# Check port
1. connect  
````
sudo putty /dev/ttyUSB0 -serial -sercfg 115200,8,n,1,N 
```

2. plug in the lamp's power supply to boot up the lamp. 
And see the log



# Enter flash mode
To be able to flash the lamp, GPIO0 must be connected to ground while the lamp boots up.
1. connect the serial to USB adapter to you computer. 
Pay special attention to the cross-over of the TX/RX pair (TX connects to RX and vice versa). 

2. Start the esphome-flasher tool and select the COM port to use. Then click on "View logs".

3. Connect the "GPIO0" to "GND". 

4. plug in the lamp's power supply to boot up the lamp. 

5. After booting, the lamp is in flash mode, release "GPIO0" from "GND"


# Make a backup of the current firmware
## Download esptool [https://github.com/espressif/esptool]
1. Enter flash mode
2. then start the esptool read_flash command:

```
esptool-master
python3 esptool.py -p /dev/ttyUSB0 read_flash 0x0 0x400000 original-firmware.bin
```


# Restore the backed up firmware
1. Enter flash mode
2. then start the esptool write_flash command:
```
python3 esptool.py --chip esp32 --port COM3 --baud 115200 write_flash 0x00 original-firmware.bin
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

# Flash new ESPHome firmware
## By esphome [Works well]
1. Enter flash mode
2. then start the esphome run command:
```
esphome run device.yaml
```
3. After flashing
power down the lamp, disconnect GPIO0 from GND and reconnect the power to boot into the new ESPHome firmware.



## By esphome-flasher [Not try]
Install
```
pip3 install -U \
    -f https://extras.wxpython.org/wxPython4/extras/linux/gtk3/ubuntu-22.04 \
    wxPython
    
pip3 install esphomeflasher

esphomeflasher
```



## By CLI [Not try]
```
python3 esptool.py --chip esp32  -p /dev/ttyUSB0 --baud 115200 \
    write_flash -z --flash_mode dout --flash_freq 40m --flash_size detect \
    0x1000 bootloader_dout_40m.bin \
    0x8000 partitions.bin \
    0xe000 boot_app0.bin \
    0x10000 firmware.bin
```


The required .bin files can be found in the following locations:
```
bootloader_dout_40m.bin: from arduino-esp32 package in tools/sdk/bin/
partitions.bin: from <config dir>/<device name>/.pioenvs/<device name>/partitions.bin
boot_app0.bin: from arduino-esp32 package in tools/partitions/
firmware.bin: from <config dir>/<device name>/.pioenvs/<device name>/firmware.bin
```



