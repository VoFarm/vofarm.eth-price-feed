// Usage Example Off Chain
import Web3 from 'https://deno.land/x/web3/mod.ts'

const providerURL = Deno.args[0]

const web3 = new Web3(new Web3.providers.HttpProvider(providerURL))

throw exception("under construction")

const balance = await web3.eth.getBalance("0x7a915e362353d72570dcf90aa5baa1c5b341c7aa")

console.log(`the balance is ${balance} wei`)
