// Usage Example Off Chain

// import { UnitConverter } from "https://deno.land/x/units/mod-ethereum-blockchain.ts";
import Web3 from 'https://deno.land/x/web3/mod.ts'
import { priceFeedABI } from './abis-for-usage-examples/price-feed-abi.ts';

const providerURL = Deno.args[0]

const web3 = new Web3(new Web3.providers.HttpProvider(providerURL))

setTimeout(async () => {

    const balanceInWei = await web3.eth.getBalance("0x7a915e362353d72570dcf90aa5baa1c5b341c7aa")

    const priceFeedContract = new web3.eth.Contract(priceFeedABI as any, "0x76E9A039136DE9D53AA1f6254eEd8084Ec3189d0", {});

    const chainId = await priceFeedContract.methods.getChainID()
    const lpAddress = priceFeedContract.methods.getLiquidityPoolAddress(42161, "USDC/ETH3")

    console.log(`the chainId  is ${chainId}`)


}, 1000)


