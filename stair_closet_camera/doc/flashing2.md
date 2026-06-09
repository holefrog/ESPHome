# Voltage
## Flash: 5V
## Serial: 3V




Flash Guide
[https://esphome.io/components/esp32_camera.html]


** SEE PICTURE[ESPCam_FTDI_wiring_21.jpg]
# Connection
ESP32-CAM	FTDI Programmer
**GND MUST using the GND next to 5V, otherwise cannot enter flahs mode**
GND	        GND 
5V	        Vcc
U0R	        TX
U0T	        RX

GPIO0-GND (temporaryly when boot)


# Port
/dev/ttyUSB0 is the port of the USB adaper on Linux. You can find what port is used by the adapter by running dmesg after plugging in the USB device. 


# Check port
1. connect  
````
sudo putty /dev/ttyUSB0 -serial -sercfg 115200,8,n,1,N 
```

2. plug in the camera's power supply to boot up the camera. 
And see the log



# Enter flash mode
To be able to flash, GPIO0 must be connected to ground while the camera boots up.
1. connect the serial to USB adapter to you computer. 
Pay special attention to the cross-over of the TX/RX pair (TX connects to RX and vice versa). 

2. Start the esphome-flasher tool and select the COM port to use. Then click on "View logs".

3. Connect the "GPIO0" to "GND". 

4. plug in the power supply to boot up the camera. 

5. After booting, the camera is in flash mode, release "GPIO0" from "GND"


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


# Flash new ESPHome firmware
## By esphome [Works well]
1. Enter flash mode
2. then start the esphome run command:
```
esphome run device.yaml

esphome upload esp32-cam-gun.yaml --device 192.168.50.128

```


```
found multiple options, please choose one:
  [1] /dev/ttyUSB0 (FT232R USB UART - FT232R USB UART)
  [2] Over The Air (camera.local)
(number): 1
esptool.py v4.4
Serial port /dev/ttyUSB0
Connecting.....
Chip is ESP32-D0WD (revision v1.0)
Features: WiFi, BT, Dual Core, 240MHz, VRef calibration in efuse, Coding Scheme None
Crystal is 40MHz
MAC: e8:db:84:17:43:c8
Uploading stub...
Running stub...
Stub running...
Changing baud rate to 460800
Changed.
Configuring flash size...
Auto-detected Flash size: 4MB
Flash will be erased from 0x00010000 to 0x000f7fff...
Flash will be erased from 0x00001000 to 0x00005fff...
Flash will be erased from 0x00008000 to 0x00008fff...
Flash will be erased from 0x0000e000 to 0x0000ffff...
Compressed 948960 bytes to 615262...
Wrote 948960 bytes (615262 compressed) at 0x00010000 in 14.1 seconds (effective 537.5 kbit/s)...
Hash of data verified.
Compressed 17440 bytes to 12127...
Wrote 17440 bytes (12127 compressed) at 0x00001000 in 0.6 seconds (effective 229.6 kbit/s)...
Hash of data verified.
Compressed 3072 bytes to 144...
Wrote 3072 bytes (144 compressed) at 0x00008000 in 0.1 seconds (effective 306.9 kbit/s)...
Hash of data verified.
Compressed 8192 bytes to 47...
Wrote 8192 bytes (47 compressed) at 0x0000e000 in 0.1 seconds (effective 454.9 kbit/s)...
Hash of data verified.

Leaving...
Hard resetting via RTS pin...
INFO Successfully uploaded program.

```

3. After flashing
power down the camera, disconnect GPIO0 from GND and reconnect the power to boot into the new ESPHome firmware.



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




## BUG
Cannot start, when check serial output, found "Brownout detector was triggered"

Reason:
5V is not good enough to give a good 3.3V. 

+ The USB cable is of poor quality, or too long.
+ Your computer's USB port cannot supply enough power to the board.
+ The ESP32Cam is defective
+ Other components in your circuit are not correctly wired up, affecting the power supply.

Solution:
Change a power adapter or cable



