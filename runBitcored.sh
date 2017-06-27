#!/bin/bash
nodeName=mynode
if [ -d $nodeName ];then  
	echo node exists.
	cd $nodeName
else
	echo new node, creating a new one.
	bitcore create $nodeName 
fi
#Weird duplicate entry caused by npm...
rm -rf /usr/local/lib/node_modules/bitcore/node_modules/bitcore-node/node_modules/bitcore-lib
bitcored
