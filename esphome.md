
#####################################################################################################################
# ESPHOME update Error:
#####################################################################################################################
ESPHOME --> UPDATE ALL

```
...
...
Processing bedside-lamp (board: esp32doit-devkit-v1; framework: espidf; platform: platformio/espressif32 @ 3.5.0)
--------------------------------------------------------------------------------
Tool Manager: Installing espressif/toolchain-xtensa-esp32 @ 8.4.0+2021r2-patch2
INFO Installing espressif/toolchain-xtensa-esp32 @ 8.4.0+2021r2-patch2
Error: Could not find the package with 'espressif/toolchain-xtensa-esp32 @ 8.4.0+2021r2-patch2' requirements for your system 'linux_aarch64'
======== [ERROR] /config/esphome/bedside-lamp.yaml ========
```


** Cause **:
```
This happens when using an ESP-IDF build (which is what the current configuration for the Bedside Lamp 2 is using) on a Raspberry Pi.

It is not a problem with your config, but it's related to the named package not being available for the CPU type that the Raspberry Pi uses. Compiling on intel/amd Linux does work. This would happen for all projects that use the new ESP-IDF framework support for ESP32 chips, so I would indeed call it an ESPHome issue yes.

I have no work-around for this at this moment, other than compiling on a different architecture. I want to spin up ESPHome on a Raspberry Pi this weekend though, to check if I can find a solution for this.

```



# ** Sulotion **:
Install ESPHome in PC

```
sudo apt install platformio
pip install -U platformio
pio pkg install -g --tool "espressif/toolchain-xtensa-esp32"

pip3 install esphome
pip3 install cffi
pip3 check
pip install -U httplib2

```


#####################################################################################################################
# Using ESPHome PC
#####################################################################################################################
## Enter flash mode
1. First, unplug your lamp's power supply, 
2. Connect device to USB, check /dev/ttyUSB0.
3. On PCB, connect the "GPIO0" to "GND". 
4. Plug in the lamp's power supply to boot up the lamp.
5. After booting, the lamp is in flash mode, release "GPIO0" from "GND"
** Lamp will not turn in flash mode. **


## Without Dashboard
1. Edit device.yaml in Home assistant[Raspberry pi] -> ESPHOME

2. Copy device.yaml and secrets.yaml back to PC folder 

3. "Enter flash mode"

4. compile and flash 
Run in the same above PC folder
```
esphome run device.yaml
```


## With ESPHome Dashboard [** conflict version of esptool!**]
Do not use this dashboard!!!
1. install
```
mkdir config
cp secrets.yaml config
pip install tornado esptool
esphome dashboard config/
```

2. "Enter flash mode"

3. open Dashboard at [http://127.0.0.1:6052/]

4. create device.yaml by Dashboard

5. UPDATE ALL 



## Change device name --> DNS cache --> cannot find the IP of new device name
solution: give new ip as option
```
esphome upload --device 192.168.50.128 cam-1.yaml 
```



#####################################################################################################################
## Changing ESPHome Node Name
#####################################################################################################################
Trying to change the name of a node or its address in the network? You can do so with the use_address option of the WiFi configuration.

Change the device name or address in your YAML to the new value and additionally set use_address to point to the old address like so:

1. Changing name from test8266 to kitchen
esphome:
  name: kitchen
  # ...

wifi:
  # ...
  use_address: cam-1.local



2. As a second step, you now need to remove the use_address option from your configuration again so that subsequent uploads will work again (otherwise it will try to upload to the old address).

# Step 2
esphome:
  name: kitchen
  # ...

wifi:
  # ...
  # Remove or comment out use_address
  # use_address: cam-1.local


#####################################################################################################################
## How to add ESP device
#####################################################################################################################
1. Settings --> Devices & Service --> ADD INTERGRATION

2. ESPHOME

3. input device ipaddress

4. input api_password





#####################################################################################################################
# Search in files:
#####################################################################################################################
```
grep -r -w 'bluetooth_proxy' 
```

