Flash Guide
[https://www.emcu-homeautomation.org/esphome-for-drive-eps8266-01s-or-eps8266-01-in-home-assistant/]


YAML
[https://www.esphome-devices.com/devices/ESP-01S-1-channel-relay]


# Connection
Soldering point <-->	Serial USB Adapter name
GND 	GND
TX 	    RX
RX 	    TX
Vcc     Vcc  (3.3V)
GIO0 --> GND


# Port
/dev/ttyUSB0 is the port of the USB adaper on Linux. 
You can find what port is used by the adapter by running dmesg after plugging in the USB device. 



# Check port
1. connect  
````
sudo putty /dev/ttyUSB0 -serial -sercfg 115200,8,n,1,N 
```
Or
```
sudo picocom -b 115200 /dev/ttyUSB0
```


# Enter flash mode
0. Connect pin IO0 to pin GND

1. connect the PCB (GND, RX and TX) to USB adapter to you computer. 

2. connect the USB adapter to you computer. 



# After flashing
unplug the adapter,
release the GIO0



# Add user to dialout group

```
sudo usermod -a -G dialout david
```

# Upload firmware
```
esphome upload 8266-01s.yaml --device /dev/ttyUSB0
esphome upload 8266-01s.yaml --device 192.168.50.54
```

