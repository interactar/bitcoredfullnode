# Warning: node:argon is based off of an odd base image.
FROM quay.io/aptible/nodejs:v4.2.x
MAINTAINER Javier Ailbirt.

#RUN apt-get install libzmq3-dev build-essential
# Install base dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        python \
        rsync \
        software-properties-common \
        git-core \
        wget \
    && rm -rf /var/lib/apt/lists/*

# Install Bitcore
RUN npm install -g bitcore
ADD bitcore-node.json /root/.bitcore/
RUN git clone https://github.com/bitaccess/insight-api.git && cd insight-api
RUN cp -rf insight-api/lib/* /usr/local/lib/node_modules/bitcore/node_modules/insight-api/lib/
EXPOSE 3001 8333
ENTRYPOINT "bitcored"
