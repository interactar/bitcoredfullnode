#!/bin/bash
nodeName=mynode
if [ -d $nodeName ];then  
	echo node exists.
	cd $nodeName
else
	echo new node, creating a new one.
	bitcore create $nodeName 
fi
#Fix multiple bitcore-lib versions installed by npm.
rm -rf /usr/local/lib/node_modules/bitcore/node_modules/bitcore-node/node_modules/bitcore-lib
ln -s /usr/local/lib/node_modules/bitcore/node_modules/bitcore-lib /usr/local/lib/node_modules/bitcore/node_modules/bitcore-node/node_modules/bitcore-lib
bitcored
