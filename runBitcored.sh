#!/bin/bash

nodeName=""
run () 
{
  #Fix multiple bitcore-lib versions installed by npm.
  rm -rf /usr/local/lib/node_modules/bitcore/node_modules/bitcore-node/node_modules/bitcore-lib
  ln -s /usr/local/lib/node_modules/bitcore/node_modules/bitcore-lib /usr/local/lib/node_modules/bitcore/node_modules/bitcore-node/node_modules/bitcore-lib
  rm -rf ./insight-api/node_modules/bitcore-lib
  rm -rf ./bitcore-wallet-service/node_modules/bitcore-lib
  rm -rf /usr/local/lib/node_modules/bitcore/node_modules/bitcore-lib ./insight-api/node_modules/bitcore-lib
  rm -rf /usr/local/lib/node_modules/bitcore/node_modules/bitcore-lib ./bitcore-wallet-service/node_modules/bitcore-lib

  echo "path $(pwd)"
  bitcored
}
case $1 in
	"livenet" )
		   echo "$1 <<<<"
                    nodeName=mynode
                    if [ -d $nodeName ];then  
                    	echo node exists.
                    	cd $nodeName
                    else
                    	echo new node, creating a new one.
                    	bitcore create $nodeName 
                    fi;;
	"testnet" )
		   echo "$1 <<<<"
                    nodeName=mytestnode
                    if [ -d $nodeName ];then  
                    	echo node exists.
                    	cd $nodeName
                    else
                    	echo new node, creating a new one.
                    	bitcore create $nodeName --testnet
                    fi;;
	* ) 
		echo "Please run as $0 (livenet|testnet) Optional (wallet) ";;
esac


if [ -z $2 ];then
   echo Got it, running only a fullnodeservice
else
   echo "Got it, running with a wallet"
   cd /root/$nodeName
   bitcore install bitcore-wallet-service
   bitcore install insight-api
fi

run
