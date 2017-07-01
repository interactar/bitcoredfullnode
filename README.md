# [[ PREREQUISITES ]] 

* 1- download/install dokcer 1.12+ and docker-compose 1.8+
![alt text](http://www.pngall.com/wp-content/uploads/2016/05/Trollface-PNG.png)

* 2- [Optional] unless you don't mind to run docker-compose by using sudoer, please grant your current user docker group permission:
```sh
sudo gpasswd -a $(whoami) docker 
```
* reboot your computer.

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
## Testnet

`docker-compose up `

## Livenet

`docker-compose -f docker-compose-livenet.yml up `



# [[ Wallet! ]]
If you need to run bitcored with a wallet service, just do:

## Testnet

```sh
 docker-compose -f docker-compose-walletservice.yml up

```

## Livenet

```sh
 docker-compose -f docker-compose-walletservice-livenet.yml up
```

# F.A.Q

* How to start working with testnet?
get some bitcoin testnet from https://testnet.manu.backend.hamburg/faucet
