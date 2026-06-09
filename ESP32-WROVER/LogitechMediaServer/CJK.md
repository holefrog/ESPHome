
#####################################################################################################
# Logitech Media Server in Ubuntu
#####################################################################################################
# Install FreeType Font
1.  prepare
```
sudo apt-get install libfreetype6-dev
```

2.  install
```
sudo perl -MCPAN -e 'install Font::FreeType'
```

3. copy
```
sudo cp /usr/local/lib/x86_64-linux-gnu/perl/5.34.0/Font/FreeType.pm /usr/share/squeezeboxserver/Font
```



# reboot and check 
1. Log setting
LMS-"Settings"-"Advanced"-"Logging"

(player.fonts) - Player Display (Font & Bitmap Information)
From **Error** To **debug**


2. restart
```
sudo service logitechmediaserver stop/start
```


3. Check log for font error.
Check LMS-"Settings"-"Information"-"Logitech Media Server Log File"


