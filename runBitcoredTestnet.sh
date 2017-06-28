#!/bin/bash
nodeName=mytestnode
if [ -d $nodeName ];then  
	echo node exists.
	cd $nodeName
else
	echo new node, creating a new one.
	bitcore create $nodeName --testnet
fi
#Fix multiple bitcore-lib versions installed by npm.
rm -rf /usr/local/lib/node_modules/bitcore/node_modules/bitcore-node/node_modules/bitcore-lib
ln -s /usr/local/lib/node_modules/bitcore/node_modules/bitcore-lib /usr/local/lib/node_modules/bitcore/node_modules/bitcore-node/node_modules/bitcore-lib
bitcored
