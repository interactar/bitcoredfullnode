#!/bin/bash
> /root/mynode/data/bitcoind.pid
nodeName="mynode"
net="livenet"
if [ $1 == "testnet" ]; then
	nodeName="mytestnode"
	net="testnet"
fi	

if [ -d $nodeName ];then  
	echo node exists !!!, Using It
	cd $nodeName
else
	bitcore create $nodeName --$net
fi
cd /root/$nodeName
/usr/local/bin/bitcoin -datadir /root/$nodeName
#Update bitcoin.conf for suiting segwit
grep connect.127.0.0.1 /root/$nodeName/data/bitcoin.conf
if [ $? -ne 0 ];then
echo "#Added for supporing Segwit
connect=127.0.0.1
onlynet=ipv4
maxconnections=1" > /root/$nodeName/data/bitcoin.conf
echo "Removing addnode sentence if its found"
sed -i s/addnode.*//g /root/$nodeName/data/bitcoin.conf 
bitcored
