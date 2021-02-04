FROM openjdk:8
MAINTAINER pepion@gmail.com

# NODE
# RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
	 apt-get install -y nodejs && \
	 apt-get install -y build-essential

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

# VOLUME
WORKDIR /setbuilder

# start it with: docker build -t tr . && docker run -v /var/run/docker.sock:/var/run/docker.sock -ti tr