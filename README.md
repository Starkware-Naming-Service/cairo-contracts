# Starknet Name Service
Starknet Name Service (SNS) is the equivalent of ENS (Ethereum Name Service) for Starknet. Starknet Name Service domains are secure domain names for the decentralized world. SNS domains provide a way for users to map human readable names to blockchain and non-blockchain resources, like Starknet account addresses. SNS domains can be bought and sold on secondary markets on NFT marketplaces like Aspect.

![](superConnector.gif)

This MVP project was designed and built under 24 hours to illustrate the bare-bone concept. The project was partly inspired by this existing [repo](https://github.com/Starkware-Naming-Service/sns95/blob/main/src/contracts/sns.cairo).

What we have built during the hackathon:
* We have created an front-end UI so that users can eeasily register an SNS with a unique domain name.
* We have added the capability for users to attach their Ethereum address to their SNS (just the same way ENS can map a Starknet address) for convenient cross-chain transfers/payments.
* We made the contract compatible with ERC721 so that SNSs can be bought and sold on Aspect's NFT marketplace.
* We have created a marketplace view so that the users can see all the SNS minted by others and also available for sale on Aspect using Aspect's API.
* We have created api endpoint so that wallets such as Braavos, Argent and Ledger can easily integrate SNS in their product.
* Given more time, we would have completed the capability to create subdomains (ex: shop.bezos.stark).

Here's the front-end repository: [link](https://github.com/Starkware-Naming-Service/sns95).

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

Compile and deploy our ERC721.cairo contract (add --network Goerli to deploy to testnet insteaed):
```sh
nile compile
nile deploy ERC721 --alias my_token sns_contract
```

## Built With
* Starknet
* Nile
* Cairo
