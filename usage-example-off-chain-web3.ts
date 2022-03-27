// Usage Example Off Chain

// import { UnitConverter } from "https://deno.land/x/units/mod-ethereum-blockchain.ts";
import Web3 from 'https://deno.land/x/web3/mod.ts'
import { priceFeedABI } from './abis-for-usage-examples/price-feed-abi.ts';

const providerURL = Deno.args[0]

export class BlockchainProxy {

    private web3: Web3

    public constructor(providerURL: string) {
        this.web3 = new Web3(new Web3.providers.HttpProvider(providerURL))
    }

    public getPrice() {

        let balanceInWei
        balanceInWei = await this.web3.eth.getBalance("spengler.eth")


        console.log(balanceInWei)
        const priceFeedContract = new this.web3.eth.Contract(priceFeedABI as any, "0x132Dee45D5F31e108fa5D8F94F41aa439eAdaf6D", {});

        const chainId = await priceFeedContract.methods.getChainID().call()
        const lpAddress = priceFeedContract.methods.getLiquidityPoolAddress(42161, "USDC/ETH3").call()

        console.log(`the chainId  is ${chainId}`)





    }
}

const blockchainProxy = new BlockchainProxy(providerURL)
blockchainProxy.getPrice()