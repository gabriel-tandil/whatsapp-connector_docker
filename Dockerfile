FROM node:14

LABEL maintainer="Gabriel Alvarez <gabriel.tandil@gmail.com>"

WORKDIR whatsapp-connector

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
	eterm \
	xvfb \
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
	mc \
	htop \
	xauth

RUN git clone https://github.com/gabriel-tandil/whatsapp-connector.git .  \
	&& npm install

COPY copyables/* .

EXPOSE 8900

CMD ./start.sh




