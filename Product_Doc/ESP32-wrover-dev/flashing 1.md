
##################################################################################################################################
# Flash
##################################################################################################################################
1. Power on

2. Run picocom
```
sudo apt install picocom
sudo picocom /dev/ttyUSB0 
```

3. Press and hold "BOOT/IO0" for 3 seconds
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



2. Verify yaml
```
yamllint esp32-wrover-dev.yaml
```


3. Enter flash mode, then start the esphome run command:
```
esphome run esp32-wrover-dev.yaml

esphome upload esp32-wrover-dev.yaml --device 192.168.50.144

esphome logs esp32-wrover-dev.yaml --device 192.168.50.144

```



