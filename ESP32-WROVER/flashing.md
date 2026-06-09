It comes with several exposed GPIOs if you want to connect other peripherals like sensors and outputs . 
Additionally,if you¡¯re not using the camera,you can use it as a regular ESP32 with a wide number of available GPIOs. 
The GPIOs with **a slash above the numbers** are the ones used by the camera. 



##################################################################################################################################
**IRM-3638T** IR receiver 
##################################################################################################################################
In NVS,"set_GPIO":
```
36=ir,...
```



##################################################################################################################################
**PCM5012** DAC
##################################################################################################################################
PCM5012 <<-->>  WROVER
VIN     -   VCC
GND     -   GND
BCK     -   (BCK - GPIO14)    "Squeezelite-ESP32"-"Hardware"-"Clock GPIO"
DIN     -   (DO - GPIO12)     "Squeezelite-ESP32"-"Hardware"-"Data GPIO"
LRCK    -   (WS - GPIO13)     "Squeezelite-ESP32"-"Hardware"-"Word Select GPIO"

In NVS,"dac_config":
```
model=I2S,bck=14,ws=13,do=12
```



##################################################################################################################################
**WM8960** DAC
##################################################################################################################################
1. Control Interface: I2C
2. Audio Communication Interface: I2S
3. Pins
- SDA       I2C Data
- SCL       I2C Clock

- CLK       I2S Clock
- WS        I2S Word Select

- TXSDA     I2S Data Out
- RXSDA     I2S Data In
- TXMCLK    I2S MCLK Out
- RXMCLK    I2S MCLK In


WM8960  <<-->>  WROVER
VCC     01  -   VCC
GND     03  -   GND

SDA     05  -   13  I2C Data
SCL     07  -   12  I2C Clock

CLK     09  -   14  "Squeezelite-ESP32"-"Hardware"-"Clock GPIO"
WS      11  -   27  "Squeezelite-ESP32"-"Hardware"-"Word Select GPIO"
RXSDA   13  -   26  "Squeezelite-ESP32"-"Hardware"-"Data GPIO"
RXMCLK  15  -   0   Master Clock In


In NVS,"dac_config":
```
bck=14,ws=27,do=26,model=WM8978,sda=13,scl=12,mck=0
```



##################################################################################################################################
**SSD1322** OLED
##################################################################################################################################
SSD1322  <<-->>  WROVER
GND     01  -   GND 
VDD     02  -   VCC
SLCK    04  -   18  Clock
SDIN    05  -   19  Data
D/C     14  -   22  Data/Command
RST     15  -   23  Reset
CS      16  -   05   Chip Select


In NVS,"display_config"
```
SPI,width=256,height=64,reset=23,cs=5,speed=8000000,driver=SSD1322
```

In NVS,"spi_config":
```
data=19,clk=18,dc=22
```



##################################################################################################################################
**SSD1306** OLED
##################################################################################################################################
SSD1306 <<-->>  WROVER
VOC     -   VCC
GND     -   GND
SDA     -   22
SCL     -   23


1. In NVS,"i2c_config":
```
sda=22,scl=23,speed=600000
```

2. In NVS,"display_config"
```
I2C,width=128,height=64,driver=SSD1306
```


##################################################################################################################################
# How to debug /dev/ttyUSB0
#################################################################################################################################
```
sudo apt install picocom

picocom -b 115200 /dev/ttyUSB0
```


##################################################################################################################################
# Download firmware
##################################################################################################################################
[https://github.com/sle118/squeezelite-esp32/tags]
Use the squeezelite-esp32-I2S-4MFlash-sdkconfig.defaults configuration file.
1. Download 
squeezelite-esp32-master-v4.3-I2S-4MFlash-16-21634.zip

2. unzip

3. cd build



##################################################################################################################################
# Flash
##################################################################################################################################
1. Power on


2. Press and hold "BOOT/IO0" for 3 seconds
picocom will output:
```
rst:0x10 (RTCWDT_RTC_RESET),boot:0x23 (DOWNLOAD_BOOT(UART0/UART1/SDIO_REI_REO_V2))
waiting for download

```

3. quit picocom


4. Flash
```
~/HomeAssistant/esphome_x86/esptool-master/esptool.py --chip esp32 --port /dev/ttyUSB0 --baud 115200 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 80m --flash_size 4MB 0x8000 partition_table/partition-table.bin 0xd000 ota_data_initial.bin 0x1000 bootloader/bootloader.bin 0x10000 recovery.bin 0x150000 squeezelite.bin
```


##################################################################################################################################
# Config
##################################################################################################################################
1. Find wifi name begins with "squeezelite-?????"

2. Conect
to "squeezelite-?????",password:squeezelite

3. setup




##################################################################################################################################
# Telnet
##################################################################################################################################
1. enable
In NVS, Change telnet_enable: y

2. reboot

3. connect
```
telnet ip 23
```


##################################################################################################################################
# MAX98357A
##################################################################################################################################
By default it is configured to mix outputs using 1M resistor (to VDD) so to configure it to left and right channels.
SD needs to be pulled-up to VDD with jumper (0 Ohms) that is going to be **LEFT** channel 
With 370-470K resistor to VDD to output **RIGHT** channel.
