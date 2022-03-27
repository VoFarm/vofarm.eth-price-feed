import { ethers } from "https://cdn.skypack.dev/ethers";
import { priceFeedABI } from "./abis-for-usage-examples/price-feed-abi.ts";

// const providerURL = "http://localhost:8545" // if you run your own ethereum node listening on 8545
// const providerURL = "http://localhost:8547" // if you run your own arbitrum mainnet node listening on 8547 // 192.168.1.107:8547
// const providerURL = "https://mainnet.infura.io/v3/<yourinfuraprojectid>" // if you use infura's nodes

const providerUrl = Deno.args[0]
const provider = new ethers.providers.JsonRpcProvider(providerUrl);


setTimeout(async () => {
    const priceFeedContract = await new ethers.Contract(
        "0x132Dee45D5F31e108fa5D8F94F41aa439eAdaf6D",
        priceFeedABI,
        provider
    );
    const chainId = priceFeedContract.getChainID()

    console.log(chainId)
}, 1000)
