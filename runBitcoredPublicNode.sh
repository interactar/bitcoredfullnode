#!/bin/bash
if [ -d mynode ];then  
	echo node exists !!!, Using It
	cd mynode
else
	echo new node, creating one.
	bitcore create mynode
	cd mynode
	bitcore-node install insight-api
	bitcore-node install insight-ui
	bitcore-node start
	# bitcore create mytestnode --testnet
fi
#Weird duplicate entry caused by npm...
rm -rf /usr/local/lib/node_modules/bitcore/node_modules/bitcore-node/node_modules/bitcore-lib
cd /root/mynode
bitcored

