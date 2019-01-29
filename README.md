# Aria2-AriaNg
[![](https://images.microbadger.com/badges/version/colinwjd/aria2-ariang.svg)](https://microbadger.com/images/colinwjd/aria2-ariang "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/colinwjd/aria2-ariang.svg)](https://microbadger.com/images/colinwjd/aria2-ariang "Get your own image badge on microbadger.com")

Aria2 with Aira-Ng web UI.

## Brief Introduction
* Use Apline:latest as base image, full image only **18Mb**.
* You can edit aria2 config file out of the image.
* Use Aria-Ng as aria2 web ui, it seems much more beautiful.
* Use darkhttpd as http server, it's very small(Only 36K after complied) and easy to use.

## Build
```
git clone https://github.com/casxt/aria2-ariang.git
cd aria2-ariang
docker build -t forer/aria2 .
```

## Specific User
1. Add user own the download dir
```
sudo groupadd sharedfile
sudo adduser --system --no-create-home --disabled-login --group sharedfile
sudo su sharedfile -c "mkdir /filedisk"
cd /filedisk
sudo su sharedfile -c "mkdir aria2"
sudo su sharedfile -c "mkdir aria2/download"
sudo su sharedfile -c "mkdir aria2/conf"
sudo chmod -R 775 /filedisk
```


## Install
1. Mount `/DOWNLOAD_DIR` to `/aria2/downloads` and `/CONFIG_DIR` to `/aria2/conf`. When starting container, it will create  `aria2.conf` file with default settings.
2. Mapping ports:
  * 6800 for aira2 service
  * 80 for Aria-Ng http service
3. Set your secret code use "SECRET" variable, this will append `rpc-secret=xxx` to aira2.conf file.

Run command like below(You may need to change the ports).
```
docker run --user=sharedfile:sharedfile \
--name aria2-ariang \
-p 6800:6800 -p 6801:80 \
-v /DOWNLOAD_DIR:/filedisk/aria2/download \
-v /CONFIG_DIR:/filedisk/aria2/conf \
-e SECRET=YOUR_SECRET_CODE forer/aria2
```
After finished, open http://serverip:6880/ in your browser for visiting Aria-Ng home page, open http://serverip:6801/ to browser your downloads folder.
