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
echo "
*Remember to add:
connect=127.0.0.1
onlynet=ipv4
maxconnections=1
*And remember to remove any line that begins with:
addnode=<whatever>"
bitcored
