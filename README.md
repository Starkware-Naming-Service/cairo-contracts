# Starknet Name Service
Starknet Name Service (SNS) is the equivalent of ENS (Ethereum Name Service) for Starknet. Starknet Name Service domains are secure domain names for the decentralized world. SNS domains provide a way for users to map human readable names to blockchain and non-blockchain resources, like Starknet account addresses. SNS domains can be bought and sold on secondary markets on NFT marketplaces like Aspect.

![](superConnector.gif)

This MVP project was designed and built under 24 hours to illustrate the bare-bone concept. Part of the concept was inspired from this previous project: .

We made the contract compatible with ERC721 so that SNSs can be bought and sold on Aspect's NFT marketplace. Additionally, we have added the capability for users to add their Ethereum address to their SNS (just the same way ENS can map a Starknet address).

You can find the [full video demo here](https://www.youtube.com/watch?v=ulhKXHfgbMw).

## Getting Started
Prerequisites:
Before installing Cairo on your machine, you need to install gmp:

```sh
sudo apt install -y libgmp3-dev # linux
brew install gmp # mac
```

### Setting up the project

Create a Python virtual environment:
```sh
python3 -m venv env
source env/bin/activate
```

Initiate Nile:
```sh
nile init
```

Run a local Starknet node
```sh
nile node
```

Compile and deploy our SNS.cairo contract (add --network Goerli to deploy to testnet insteaed):
```sh
nile compile
nile deploy SNS --alias my_token sns_contract
```

## Built With
* Starknet
* Nile
* Cairo
