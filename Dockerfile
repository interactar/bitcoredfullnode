# Warning: node:argon is based off of an odd base image.
FROM quay.io/aptible/nodejs:v8.2.x
MAINTAINER Javier Ailbirt.

#RUN apt-get install libzmq3-dev build-essential
# Install base dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        libssl-dev \
        rsync \
        software-properties-common \
        git-core \
        libpgm-5.1.0 \
        curl \
        wget ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install  libzmq3-dev lib which is not listed at wheezy debian packages.
RUN wget http://ftp.cl.debian.org/debian/pool/main/z/zeromq3/libzmq3-dev_3.2.3+dfsg-2~bpo70+1_amd64.deb \
    && wget http://ftp.cl.debian.org/debian/pool/main/z/zeromq3/libzmq3_3.2.3+dfsg-2~bpo70+1_amd64.deb

RUN dpkg -i *.deb
RUN rm -f *.deb

# Install Bitcore
RUN npm install -g --unsafe-perm=true bitcore
RUN git clone https://github.com/bitaccess/insight-api.git && cd insight-api && npm install
RUN cp -rf insight-api/lib/* /usr/local/lib/node_modules/bitcore/node_modules/insight-api/lib/

#Remove bitcore-lib because it's installed twice.
RUN rm -rf /usr/local/lib/node_modules/bitcore/node_modules/insight-api/node_modules/bitcore-lib
RUN rm -rf /usr/local/lib/node_modules/bitcore/node_modules/bitcore-node/node_modules/bitcore-lib
RUN rm -rf /usr/local/lib/node_modules/bitcore/node_modules/bitcore-message/node_modules/bitcore-lib
# Create Symblinks due to diferent versions of bitcore-lib installed by bitcore..
RUN ln -s /usr/local/lib/node_modules/bitcore/node_modules/bitcore-lib /usr/local/lib/node_modules/bitcore/node_modules/insight-api/node_modules/bitcore-lib


#Upgrade bitcoind for supporting segwit
WORKDIR /opt/local/bin
RUN wget https://s3.amazonaws.com/endophi-bins/bitcoin-cli
RUN wget https://s3.amazonaws.com/endophi-bins/bitcoind
RUN wget https://s3.amazonaws.com/endophi-bins/bitcoin-tx
RUN wget https://s3.amazonaws.com/endophi-bins/test_bitcoin


#remove bitcoind binaries and replace them with the new ones.
RUN rm -rf /usr/local/lib/node_modules/bitcore/node_modules/bitcore-node/bin/
RUN ln -s /opt/local/bin /usr/local/lib/node_modules/bitcore/node_modules/bitcore-node/bin   

ENV destDir /root

RUN cd ${destDir}
WORKDIR ${destDir}
COPY . ${destDir}
EXPOSE 3001 8333

CMD ["./runBitcored.sh"]
