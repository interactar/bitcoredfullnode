# Warning: node:argon is based off of an odd base image.
#FROM quay.io/aptible/nodejs:v8.2.x
FROM ubuntu:xenial
MAINTAINER Javier Ailbirt.

# Install base dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        libssl-dev \
        rsync \
        software-properties-common \
        git-core \
        curl \
        wget ca-certificates \
        libboost-all-dev \
        libzmq3-dev \ 
        build-essential

# Install  libzmq3-dev lib which is not listed at wheezy debian packages.
#RUN wget http://ftp.cl.debian.org/debian/pool/main/z/zeromq3/libzmq3-dev_3.2.3+dfsg-2~bpo70+1_amd64.deb \
#    && wget http://ftp.cl.debian.org/debian/pool/main/z/zeromq3/libzmq3_3.2.3+dfsg-2~bpo70+1_amd64.deb
#
#RUN dpkg -i *.deb
#RUN rm -f *.deb

# Using Ubuntu
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs 

# Install Bitcore
RUN npm install -g --unsafe-perm=true bitcore
#RUN git clone https://github.com/bitaccess/insight-api.git && cd insight-api && npm install
#RUN cp -rf insight-api/lib/* /usr/local/lib/node_modules/bitcore/node_modules/insight-api/lib/

#15-1 PRUEBO A VER SI SE DEJA DE JODER #Remove bitcore-lib because it's installed twice.
#15-1 PRUEBO A VER SI SE DEJA DE JODER #RUN rm -rf /usr/lib/node_modules/bitcore/node_modules/insight-api/node_modules/bitcore-lib
#15-1 PRUEBO A VER SI SE DEJA DE JODER #RUN rm -rf /usr/lib/node_modules/bitcore/node_modules/bitcore-node/node_modules/bitcore-lib
#15-1 PRUEBO A VER SI SE DEJA DE JODER #RUN rm -rf /usr/lib/node_modules/bitcore/node_modules/bitcore-message/node_modules/bitcore-lib
#15-1 PRUEBO A VER SI SE DEJA DE JODER 
#15-1 PRUEBO A VER SI SE DEJA DE JODER # Create Symblinks due to diferent versions of bitcore-lib installed by bitcore..
#15-1 PRUEBO A VER SI SE DEJA DE JODER #RUN ln -s /usr/lib/node_modules/bitcore/node_modules/bitcore-lib /usr/lib/node_modules/bitcore/node_modules/insight-api/node_modules/bitcore-lib


#Upgrade bitcoind for supporting segwit
WORKDIR /opt/local/bin
RUN wget https://s3.amazonaws.com/endophi-bins/bitcoin-cli
RUN wget https://s3.amazonaws.com/endophi-bins/bitcoind
RUN wget https://s3.amazonaws.com/endophi-bins/bitcoin-tx
RUN wget https://s3.amazonaws.com/endophi-bins/test_bitcoin
RUN chmod +x *


#remove bitcoind binaries and replace them with the new ones.
RUN rm -rf /usr/lib/node_modules/bitcore/node_modules/bitcore-node/bin/bitcoin-0.12.1/bin/
RUN ln -s /opt/local/bin /usr/lib/node_modules/bitcore/node_modules/bitcore-node/bin/bitcoin-0.12.1/bin


#Berkley Database
RUN wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz
RUN tar xzvf db-4.8.30.NC.tar.gz
RUN cd db-4.8.30.NC/build_unix/
RUN ../dist/configure --enable-cxx
RUN make
RUN make install
RUN ln -s /usr/local/BerkeleyDB.4.8 /usr/include/db4.8
RUN ln -s /usr/include/db4.8/include/* /usr/include
RUN ln -s /usr/include/db4.8/lib/* /usr/lib

RUN apt-get clean && rm -rf /var/lib/apt/lists/*


ENV destDir /root

RUN cd ${destDir}
WORKDIR ${destDir}
COPY . ${destDir}
EXPOSE 3001 8333

CMD ["./runBitcored.sh"]
