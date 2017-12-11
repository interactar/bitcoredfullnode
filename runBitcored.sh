#!/bin/bash
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
#Weird duplicate entry caused by npm...
> /root/$nodeName/data/bitcoind.pid
cd /root/$nodeName
bitcored
