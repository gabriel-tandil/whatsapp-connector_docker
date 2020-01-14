FROM debian:stable-slim

LABEL maintainer="Gabriel Alvarez <gabriel.tandil@gmail.com>"

ENV VNC_SCREEN_SIZE 1024x768

COPY copyables /

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
	fonts-noto-cjk \
	supervisor \
	x11vnc \
	fluxbox \
	eterm \
	npm \
	xvfb \
	xterm \
	git \
	ca-certificates \
	fonts-liberation \
	libappindicator3-1 \
	libasound2 \
	libatk-bridge2.0-0 \
	libatk1.0-0 \
	libatspi2.0-0 \
	libc6 \
	libcairo2 \
	libcups2 \
	libdbus-1-3 \
	libexpat1 \
	libgcc1 \
	libgdk-pixbuf2.0-0 \
	libglib2.0-0 \
	libgtk-3-0 \
	libnspr4 \
	libnss3 \
	libpango-1.0-0 \
	libpangocairo-1.0-0 \
	libx11-6 \
	libx11-xcb1 \
	libxcb1 \
	libxcomposite1 \
	libxcursor1 \
	libxdamage1 \
	libxext6 \
	libxfixes3 \
	libxi6 \
	libxrandr2 \
	libxrender1 \
	libxss1 \
	libxtst6 \
	wget \
	xdg-utils \
	mc

RUN apt-get clean \
	&& rm -rf /var/cache/* /var/log/apt/* /var/lib/apt/lists/* /tmp/* \
	&& useradd -m chrome \
	&& usermod -s /bin/bash chrome \
	&& ln -s /update /usr/local/sbin/update \
	&& mkdir -p /home/chrome/.fluxbox \
	&& echo ' \n\
		session.screen0.toolbar.visible:        false\n\
		session.screen0.fullMaximization:       true\n\
		session.screen0.maxDisableResize:       true\n\
		session.screen0.maxDisableMove: true\n\
		session.screen0.defaultDeco:    NONE\n\
	' >> /home/chrome/.fluxbox/init \
	&& chown -R chrome:chrome /home/chrome/.fluxbox

RUN cd /home/chrome \
	&& git clone https://github.com/gabriel-tandil/whatsapp-connector.git \
	&& cd whatsapp-connector \
	&& npm install \
	&& chown -R chrome:chrome /home/chrome/whatsapp-connector

VOLUME ["/home/chrome"]

EXPOSE 5900
EXPOSE 8900

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
