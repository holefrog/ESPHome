#####################################################################################################
# Sorting play list
#####################################################################################################
Install plugin "Material", then using http://lmsserver:9001/material 




#####################################################################################################
# CJK: Logitech Media Server on Ubuntu
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


#####################################################################################################
# CJK: Logitech Media Server on QNAP [Not success]
#####################################################################################################
# Install application by Entware
You can install a package manager called Entware [https://github.com/Entware/Entware-ng/wiki/Install-on-QNAP-NAS] on your NAS to install extra tools and packages for Linux. Please note that this is a free application developed by a third-party and as such is not officially supported by QNAP.

```
export PATH=/opt/bin:/opt/sbin:$PATH
opkg update
```


# Install gcc/perl by Entware
```
opkg install gcc
opkg list-installed
```


# Before you start to install perl modules please install
[https://github.com/entware/entware/wiki/Self-installation-of-perl-modules]

## gcc
follow instructions here: Using-GCC-for-native-compilation[https://github.com/Entware/Entware/wiki/Using-GCC-for-native-compilation]. 
You do not need to assign any special environment variables by running /opt/bin/gcc_env.sh, all needed flags will be used automatically by perl.


## All perlbase modules. Use the command:
```
opkg list | grep perlbase- | sed 's/ - .*//' | xargs opkg install
```

## perl-dev package with headers 
```
opkg install perl-dev
```

## perl tests packages
```
opkg install perl-test-warn 
opkg install perl-test-harness --force-overwrite
```
please use --force-ovewrite flag. The last package has same files in common with one of perlbase packages.

## make:
```
opkg install make
```


## other
```
opkg install perlbase-base perlbase-config perlbase-autoloader perlbase-carp perlbase-cwd perlbase-dynaloader perlbase-errno perlbase-fcntl perlbase-file perlbase-file-temp perlbase-getopt perlbase-io perlbase-list perlbase-params-check perlbase-posix perlbase-regexp perlbase-socket perlbase-storable perlbase-sys-syslog perlbase-time-hires perlbase-time-local perlbase-time-piece perlbase-universal perlbase-utf8 perlbase-constant perlbase-scalar-list-utils perlbase-text-balanced perlbase-carp perlbase-file-spec perlbase-digest-sha perlbase-cpan-perl-releases perlbase-text-parsewords
```

## Maunual Install FreeType
To manually install FreeType on a Linux system, you can follow these general steps. Keep in mind that the specific commands and package names might vary depending on your Linux distribution.

1. Download FreeType:
Visit the FreeType download page: FreeType Download. Download the source code (usually a .tar.gz or .tar.bz2 archive).
```
wget https://nongnu.askapache.com/freetype/freetype-2.9.tar.gz
```


2. Extract the Archive:
```
tar -xzvf freetype-2.9.tar.gz
```


3. Navigate to the FreeType Directory:
Change into the extracted directory:

````
cd freetype-2.9
```


4. Configure:
Run the configure script to prepare the build environment:
```
./configure
```


5. Compile:
```
make
```


6. Install:
```
sudo make install
```
This will copy the necessary files to the system directories.


7. Update Library Cache:
After installation, update the library cache:

```
sudo ldconfig
```
This step ensures that the system recognizes the newly installed library.


8. At this point, FreeType should be installed on your system. You can check the installed version using:
```
freetype-config --version
```


9. Once FreeType is installed, you can try installing the Font::FreeType Perl module again, providing the correct library and include paths during the installation:

```
sudo perl -MCPAN -e 'MYEXTLIB="-lfreetype" MYEXTINC="-I/usr/local/include/freetype2" install Font::FreeType'
```

Replace /usr/local/include/freetype2 with the actual path where FreeType headers are located.



## Install FreeType
```
sudo perl -MCPAN -e 'install Test2::Util'
sudo perl -MCPAN -e 'install Capture::Tiny'
sudo perl -MCPAN -e 'install Mock::Config'
opkg list | grep font | sed 's/ - .*//' | xargs opkg install


sudo perl -MCPAN -e 'install Font::FreeType'
```


## copy
```
mkdir /share/CACHEDEV1_DATA/.qpkg/LogitechMediaServer/SlimServer/Font
chgrp -R everyone /share/CACHEDEV1_DATA/.qpkg/LogitechMediaServer/SlimServer/Font
chown -R squeezeboxserver /share/CACHEDEV1_DATA/.qpkg/LogitechMediaServer/SlimServer/Font

sudo cp -r -v /share/CACHEDEV1_DATA/.qpkg/Entware-ng/lib/perl5/5.26/Font/ /share/CACHEDEV1_DATA/.qpkg/LogitechMediaServer/SlimServer/
chgrp everyone /share/CACHEDEV1_DATA/.qpkg/LogitechMediaServer/SlimServer/Font/*
chown squeezeboxserver /share/CACHEDEV1_DATA/.qpkg/LogitechMediaServer/SlimServer/Font/*

```

```
mkdir -p /usr/local/Perl-5.36/lib/perl5/site_perl/5.36.0
sudo cp -r -v /share/CACHEDEV1_DATA/.qpkg/Entware-ng/lib/perl5/5.26/ /usr/local/Perl-5.36/lib/perl5/site_perl/5.36.0
mv /usr/local/Perl-5.36/lib/perl5/site_perl/5.36.0/5.26/* /usr/local/Perl-5.36/lib/perl5/site_perl/5.36.0

chgrp everyone /usr/local/Perl-5.36/lib/perl5/site_perl/5.36.0/*
chown squeezeboxserver /usr/local/Perl-5.36/lib/perl5/site_perl/5.36.0/*

```





[23-12-12 21:13:34.3754] Slim::Display::Lib::Fonts::__ANON__ (84) 
```
Can't locate loadable object for module Font::FreeType in @INC (@INC contains: 
/share/CACHEDEV1_DATA/.qpkg/LogitechMediaServer/SlimServer/Cache/InstalledPlugins/Plugins/SongLyrics/lib 
/share/CACHEDEV1_DATA/.qpkg/LogitechMediaServer/SlimServer/Cache/InstalledPlugins 
/share/CACHEDEV1_DATA/.qpkg/LogitechMediaServer/SlimServer/CPAN/arch/5.36/x86_64-linux-thread-multi 
/share/CACHEDEV1_DATA/.qpkg/LogitechMediaServer/SlimServer/CPAN/arch/5.36/x86_64-linux-thread-multi/auto 
/share/CACHEDEV1_DATA/.qpkg/LogitechMediaServer/SlimServer/CPAN/arch/5.36.0/x86_64-linux-thread-multi 
/share/CACHEDEV1_DATA/.qpkg/LogitechMediaServer/SlimServer/CPAN/arch/5.36.0/x86_64-linux-thread-multi/auto 
/share/CACHEDEV1_DATA/.qpkg/LogitechMediaServer/SlimServer/CPAN/arch/x86_64-linux-thread-multi 
/share/CACHEDEV1_DATA/.qpkg/LogitechMediaServer/SlimServer/CPAN/arch/5.36 
/share/CACHEDEV1_DATA/.qpkg/LogitechMediaServer/SlimServer/lib 
/share/CACHEDEV1_DATA/.qpkg/LogitechMediaServer/SlimServer/CPAN 
/share/CACHEDEV1_DATA/.qpkg/LogitechMediaServer/SlimServer 
/usr/local/Perl-5.36/lib/perl5/site_perl/5.36.0/x86_64-linux-thread-multi 
/usr/local/Perl-5.36/lib/perl5/site_perl/5.36.0 
/usr/local/Perl-5.36/lib/perl5/5.36.0/x86_64-linux-thread-multi 
/usr/local/Perl-5.36/lib/perl5/5.36.0) at /share/CACHEDEV1_DATA/.qpkg/LogitechMediaServer/SlimServer/Slim/Display/Lib/Fonts.pm line 83.
Compilation failed in require at /share/CACHEDEV1_DATA/.qpkg/LogitechMediaServer/SlimServer/Slim/Display/Lib/Fonts.pm line 83.
```



# uninstall all
```
opkg list | sed 's/ - .*//' | xargs opkg remove

opkg list | sed 's/ - .*//' | more
```



#####################################################################################################
# CJK: Logitech Media Server on QNAP  [Docker]
#####################################################################################################
# Pull Image
1. Run "Container Station"


2. "Container Station" - Images - Explore 
search "logitechmediaserver"


3. Deploy lmscommunity/logitechmediaserver


# Container
1. Create container
"Container Station" - Images, Choose "lmscommunity/logitechmediaserver", Run it [Play icon] to "Create Container".


2. Configure container
+ Name: LMS
 

+ Publish network ports:
Host: 9000 Container: 9000 TCP
Host: 9090 Container: 9090 TCP

Host: 3483 Container: 3483 TCP
Host: 3483 Container: 3483 UDP

+ Do not Click on "Publish All Exposed Ports"


+ Advanced Setting-Storage
Volume: /share/CACHEDEV2_DATA/Media/Audio/Popular
Container: /music

Add New Varibale
Volume: /etc/localtime:ro 
Container: /etc/localtime

Volume: /etc/timezone:ro 
Container: /etc/timezone


+ Click on Next




3. Copy IR file
connect to container
```
docker exec -i -t LMS bash

cd /lms/IR

cp /music/*.ir .

```




# LMS Enable plugins
## SqueezeEPS32
## Podcast
## Material skin (for sort songs)
http://lms:9000/material

## Youtube
1. Get Youtube Data API Key
https://console.cloud.google.com/apis/credentials?project=youtube-data-api-408101

2. Check Key:
https://www.googleapis.com/youtube/v3/videos?id=jeqH4eMGjhY&key=AIzaSyAiJ3Wjk9E9Ly41oQTmpcq5VvjYKtfbMMw&part=snippet


3. Set key
In seting, input Youtube Data API v3 Key: AIzaSyAiJ3Wjk9E9Ly41oQTmpcq5VvjYKtfbMMw



# LMS Add podcast feed
in LMS - Settings - Podcast
Add a new feed: http://192.227.234.149/ytf/tengfei.rss




# LMS-Settings-mysqueezebox APP
1. LMS-mysqueezebox
login


2. login in to https://www.mysqueezebox.com
Add Podcast / TuneIn Radio and login into TuneIn.



# Players settings
player - Audio - player name: ESP-Duo
player - Audio - Server: 192.168.50.210:3483
Apply





#####################################################################################################
# Container 
#####################################################################################################
# run container
```
docker run -v /etc/localtime:/etc/localtime:ro lmscommunity/logitechmediaserver:latest
```


# list running containers
```
docker ps
```
CONTAINER ID   IMAGE                                     COMMAND             CREATED         STATUS         PORTS                                    NAMES
c0c7a08e95b6   lmscommunity/logitechmediaserver:latest   "start-container"   6 minutes ago   Up 6 minutes   3483/tcp, 9000/tcp, 9090/tcp, 3483/udp   exciting_poincare


# stop container by container ID above
```
docker stop c0c7a08e95b6
```

# connect to container
```
docker exec -i -t LMS bash
```

# Inspect container
```
docker inspect c0c7a08e95b6 > inspect.json

cp inspect.json /share/CACHEDEV2_DATA/Data/Temp/
```

find / -type f \( -name "*.yml" -o -name "*.json" \) -exec grep "c0c7a08e95b6" {} + 2>/etc/nul



# Restart container by ID
docker restart c0c7a08e95b6




#####################################################################################################
# Docker-compose
#####################################################################################################
Ref: [https://www.smarthomebeginner.com/qnap-docker-compose-guide-2023/]

# Install
1. Install "Container Station"


2. Upgrade Docker Compose
+ Show the CPU architecture
```
uname -m
```
 
+ Move into docker-compose binary folder
```
cd /share/CACHEDEV1_DATA/.qpkg/container-station/usr/local/lib/docker/cli-plugins/
mv docker-compose docker-compose.bak
```

+ Download 
```
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o docker-compose
sudo chmod +x docker-compose
sudo chown admin:administrators docker-compose
sudo chmod +x docker-compose
sudo chmod 755 docker-compose

./docker-compose --version
 
# Check compose version
docker-compose -v
```


# Create docker-compose.yml
Create docker-compose.yml
```
version: '3'
services:
  logitech_media_server:
    image: lmscommunity/logitechmediaserver:latest
    ports:
      - "3483:3483/tcp"
      - "9000:9000/tcp"
      - "9090:9090/tcp"
      - "3483:3483/udp"

    environment:
      - TZ=PST8PDT7

    volumes:
      - "/share/CACHEDEV2_DATA/Media/Audio/Popular:/music"

    command: ["cp", "/share/CACHEDEV2_DATA/Media/Audio/Popular/*.ir", "/logitech_media_server/IR/"]
    
    networks:
      - myNetwork

networks:
  myNetwork:
    driver: bridge
```



# "Container Station" - "Create application"
Use docker-compose.yml to crearte an application.






docker exec -i -t 7b7710823f3e bash 

