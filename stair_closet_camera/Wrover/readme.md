#####################################################################################################################
# Install
#####################################################################################################################
run script
```
install_esphome.sh
```


#####################################################################################################################
# Prepare board
#####################################################################################################################
```
 sudo usermod -a -G dialout $USER
 newgrp dialout
```
**When flah, NO need press any key (e.g. boot, reset)**


#####################################################################################################################
# Usage
#####################################################################################################################
1. Activate the environment
```
source ~/esphome/venv/bin/activate
```

2. Verify yaml
```
yamllint esp32-wrover-dev.yaml
```

3. Start the esphome run command 
# USB connect
**FIRST time**
```
esphome run esp32-wrover-dev.yaml --device /dev/ttyUSB0
esphome logs esp32-wrover-dev.yaml  --device /dev/ttyUSB0
```


# WIFI connect
**Second time**
```
esphome run esp32-wrover-dev.yaml --device 192.168.50.252
esphome logs esp32-wrover-dev.yaml --device 192.168.50.252
```

# LOAD only
```
esphome upload esp32-wrover-dev.yaml --device /dev/ttyUSB0
esphome upload esp32-wrover-dev.yaml --device 192.168.50.252 / 133
```


#####################################################################################################################
# How to reset configuration to factory settings
#####################################################################################################################
# Source: 
Youtube[https://www.youtube.com/watch?v=3oEvXhgHZHo&t=144s]


# To reset the settings to factory defaults, follow these instructions:
1. Download Factory reset and Bootloader Repair bin file (ESP32 4Mbit)
URL: [https://raw.githubusercontent.com/itsbhupendrasingh/ESP32-Factory-Reset-S2-and-bootloader/Master/Factory_Reset_And_Bootloader_Repair.bin]

2. Using **CHROME** Go to URL[https://espressif.github.io/esptool-js/]

3. "Erase"

4. Change "Flash Address" From 0x1000 to 0x0000

5. "Choose File" (Factory_Reset_And_Bootloader_Repair.bin) and "Program"

6. "Disconnect"

7. Output
```
esptool.js
Serial port WebSerial VendorID 0x1a86 ProductID 0x7523
Connecting...
Detecting chip type... ESP32
Chip is ESP32-D0WDQ6 (revision 1)
Features: Wi-Fi, BT, Dual Core, VRef calibration in efuse, BLK3 partially reserved, Coding Scheme 3/4
Crystal is 40MHz
MAC: 30:ae:a4:4d:3c:f8
Uploading stub...
Running stub...
Stub running...
Changing baudrate to 921600
Changed
Erasing flash (this may take a while)...
Chip erase completed successfully in 2.103s
Compressed 3084992 bytes to 258749...
Writing at 0x0... (6%)
Writing at 0x11232... (12%)
Writing at 0x1e506... (18%)
Writing at 0x24672... (25%)
Writing at 0x29b09... (31%)
Writing at 0x2ed83... (37%)
Writing at 0x33ed5... (43%)
Writing at 0x3be62... (50%)
Writing at 0x448c9... (56%)
Writing at 0x49e1d... (62%)
Writing at 0x4f35d... (68%)
Writing at 0x2d6050... (75%)
Writing at 0x2db23d... (81%)
Writing at 0x2e1571... (87%)
Writing at 0x2e7e10... (93%)
Writing at 0x2ed36c... (100%)
Wrote 3084992 bytes (258749 compressed) at 0x0 in 15.594 seconds.
Hash of data verified.
Leaving...
```

