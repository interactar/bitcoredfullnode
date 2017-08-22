# [[ PREREQUISITES ]] 

* 1- download/install dokcer 1.12+ and docker-compose 1.8+

* 2- [Optional] unless you don't mind to run docker-compose by using ``` sudo```, please grant your current user with docker group permission:
```sh
sudo gpasswd -a $(whoami) docker 
```
* reboot your computer.

# [[ INTRO ]]

This orchestation uses three dockers:

*The Public Node which has enabled insight web/api, and https certs and is used to verify transactions from outside.
*The Private Node which has a limited network access and limited plugins for security purposes.
*The Wallet Which is the BWS service and should be configured to talk with your public NODE.

You are able to run all this dockers in one server, also you can run each docker-compose in a different server.

# [[ INSTALATION ]] 

* 1- clone this repo
```sh
git clone git@github.com:interactar/bitcoredfullnode.git
```

* 2- cd bitcoredfullnode
```sh
cd bitcoredfullnode
```
# [[ RUN! ]]

## Private Full Node
## Testnet

`docker-compose up `

## Livenet

`docker-compose -f docker-compose-livenet.yml up `

# Public Full Node
## Testnet

 Edit docker-compose-publicNode.yml file by replacing ```command: "/runBitcoredPublicNode.sh livenet"``` setting with ```command: "/runBitcoredPublicNode.sh testnet"```
`docker-compose -f docker-compose-publicNode.yml up `

## Livenet
Before you run,please place your pem and key files under ./bitcoreroot and then configure nodecfg/public_bitcore-node.json settings to fit your key and pem files:
   "key": "./xxxxxxxxx.key",
   "cert": "./xxxxxxxxx.pem"



`docker-compose -f docker-compose-publicNode.yml up `


#  Wallet
If you need to run bitcored with a wallet service, please run:

## Testnet
This flavor comes with copay up and running, that way you can test your overall setup by browsing http://0.0.0.0:8081

```sh
 docker-compose -f docker-compose-walletservice.yml up

```

## Livenet
###Before you run, please configure walletcfg/config.js settings to fit your setup:
You should modify the "blockchainExplorerOpts" block by replacing the ```url: 'https://xxxxxxxxxxxxx.com:3001/insight'``` setting with your public full node url address.

```sh
 docker-compose -f docker-compose-walletservice-livenet.yml up
```

# F.A.Q

* How to start working with testnet?
get some bitcoin testnet from https://testnet.manu.backend.hamburg/faucet
