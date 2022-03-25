export const priceFeedABI = [
    {
        "inputs": [],
        "name": "getChainID",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "chainId",
                "type": "uint256"
            },
            {
                "internalType": "string",
                "name": "pair",
                "type": "string"
            }
        ],
        "name": "getLiquidityPoolAddress",
        "outputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "chainId",
                "type": "uint256"
            },
            {
                "internalType": "string",
                "name": "pair",
                "type": "string"
            }
        ],
        "name": "getPriceForTradingPair",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint160",
                "name": "slot0",
                "type": "uint160"
            },
            {
                "internalType": "uint256",
                "name": "magicDecimalMystery",
                "type": "uint256"
            }
        ],
        "name": "getPriceFromSlot0",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "pure",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getRegisteredLiquidityPools",
        "outputs": [
            {
                "components": [
                    {
                        "internalType": "uint256",
                        "name": "chainId",
                        "type": "uint256"
                    },
                    {
                        "internalType": "string",
                        "name": "pair",
                        "type": "string"
                    },
                    {
                        "internalType": "address",
                        "name": "lpAddress",
                        "type": "address"
                    }
                ],
                "internalType": "struct PriceFeedLiquidityPoolBased.liquidityPoolInfoStruct[]",
                "name": "",
                "type": "tuple[]"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "chainId",
                "type": "uint256"
            },
            {
                "internalType": "string",
                "name": "pair",
                "type": "string"
            }
        ],
        "name": "getSlot0ForTradingPair",
        "outputs": [
            {
                "internalType": "uint160",
                "name": "",
                "type": "uint160"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "chainId",
                "type": "uint256"
            },
            {
                "internalType": "string",
                "name": "pair",
                "type": "string"
            },
            {
                "internalType": "address",
                "name": "lpAddress",
                "type": "address"
            }
        ],
        "name": "registerLiquidityPool",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    }
]