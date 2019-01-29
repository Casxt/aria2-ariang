FROM alpine:latest

MAINTAINER colinwjd <wjdwjd@live.cn>

RUN apk update \
	&& apk add --no-cache --update aria2 darkhttpd \
	&& mkdir -p aria2/conf aria2/conf-temp aria2/downloads aria-ng \
	&& wget --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/1.0.0/AriaNg-1.0.0-AllInOne.zip \
	&& unzip AriaNg-1.0.0-AllInOne.zip -d aria-ng \
	&& rm -rf AriaNg-1.0.0-AllInOne.zip
RUN groupadd sharedfile && adduser --group sharedfile
USER sharedfile
COPY init.sh /aria2/init.sh
COPY conf-temp /aria2/conf-temp

WORKDIR /
VOLUME ["/aria2/conf", "/aria2/downloads"]
EXPOSE 6800 80

CMD ["/aria2/init.sh"]
