FROM openjdk:8
MAINTAINER pepion@gmail.com

ARG REFRESHED_AT
ENV REFRESHED_AT $REFRESHED_AT
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# NODE
# RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
	 apt-get install -y nodejs && \
	 apt-get install -y build-essential

RUN npm install -g yarn
RUN yarn global add @angular/cli
RUN ng config -g cli.packageManager yarn
RUN yarn global add @angular-devkit/build-angular

# DOCKER
#RUN apt-get update
RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88

RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

RUN apt-get update
RUN apt-get install -y docker-ce docker-ce-cli containerd.io
RUN service docker start

# autoreconf
RUN apt-get install -y automake autoconf libtool pkg-config nasm build-essential dh-autoreconf

# headless-chromium
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y --no-install-recommends chromium libxss1 libx11-xcb-dev
ENV CHROME_BIN=chromium
# CMD ["npm", "start"]
RUN chromium --version

RUN npm install -g gulp

RUN apt-get install -y --no-install-recommends mc

# VOLUME
WORKDIR /setbuilder

# start it with: docker build -t tr . && docker run -v /var/run/docker.sock:/var/run/docker.sock -ti tr
