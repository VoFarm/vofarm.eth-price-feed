// SPDX-License-Identifier: GNU GPL V3
pragma solidity ^0.8.6;

import "@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol";

// import 'https://raw.githubusercontent.com/Uniswap/v3-core/main/contracts/interfaces/IUniswapV3Pool.sol'

contract PriceFeedLiquidityPoolBased {
    struct liquidityPoolInfoStruct {
        uint256 chainId;
        string pair;
        address lpAddress;
    }

    liquidityPoolInfoStruct[] liquidityPools;

    // 1 "USDC/ETH3" 0x8ad599c3A0ff1De082011EFDDc58f1908eb6e6D8
    function registerLiquidityPool(
        uint256 chainId,
        string memory pair,
        address lpAddress
    ) public {
        require(
            getLiquidityPoolAddress(chainId, pair) ==
                0x0000000000000000000000000000000000000000,
            "for security reasons no one (not even the dance planner) can replace a once registered liquidity pool"
        );
        require(
            msg.sender == 0x4396A292512AA418087645B56a3a76333Bd10e28,
            "please contact https://t.me/danceplanner to add a validated liquidity pool based price feed source"
        );
        liquidityPools.push(liquidityPoolInfoStruct(chainId, pair, lpAddress));
    }

    function getRegisteredLiquidityPools()
        public
        view
        returns (liquidityPoolInfoStruct[] memory)
    {
        return liquidityPools;
    }

    function getLiquidityPoolAddress(uint256 chainId, string memory pair)
        public
        view
        returns (address)
    {
        uint256 i = 0;
        address result;
        for (i; i < liquidityPools.length; i++) {
            if (
                liquidityPools[i].chainId == chainId &&
                keccak256(abi.encodePacked(liquidityPools[i].pair)) ==
                keccak256(abi.encodePacked(pair))
            ) {
                result = liquidityPools[i].lpAddress;
            }
        }

        return result;
    }

    function getPriceForTradingPair(uint256 chainId, string memory pair)
        public
        view
        returns (uint256)
    {
        uint256 priceFromSlot = getPriceFromSlot0(
            getSlot0ForTradingPair(chainId, pair),
            12
        );

        return priceFromSlot;
    }

    function getSlot0ForTradingPair(uint256 chainId, string memory pair)
        public
        view
        returns (uint160)
    {
        address lpAddress = getLiquidityPoolAddress(chainId, pair);

        require(
            lpAddress != 0x0000000000000000000000000000000000000000,
            "no liquidity pool registered in this smart contract for the given pair"
        );

        IUniswapV3Pool pool = IUniswapV3Pool(lpAddress);

        (
            uint160 sqrtPriceX96,
            int24 tick,
            uint16 observationIndex,
            uint16 observationCardinality,
            uint16 observationCardinalityNext,
            uint8 feeProtocol,
            bool unlocked
        ) = pool.slot0();

        return sqrtPriceX96;
    }

    // e.g. 1419822734404674842004188506004274 // 12 // get slot0 - compare e.g.  https://etherscan.io/address/0x88e6A0c2dDD26FEEb64F039a2c41296FcB3f5640#readContract
    function getPriceFromSlot0(uint160 slot0, uint256 magicDecimalMystery)
        public
        pure
        returns (uint256)
    {
        return (2**192 * (10**magicDecimalMystery)) / (uint256(slot0)**2);
    }

    function getChainID() public view returns (uint256) {
        uint256 id;
        assembly {
            id := chainid()
        }
        return id;
    }
}

//     this price feed could be tested - e.g. with the following uniswap v3 contracts

//     Ethereum Mainnet
//     pools["USDC/ETH05"] = 0x88e6A0c2dDD26FEEb64F039a2c41296FcB3f5640;
//     pools["USDC/ETH3"]  = 0x8ad599c3A0ff1De082011EFDDc58f1908eb6e6D8;
//     pools["DAI/USDC01"]  = 0x5777d92f208679DB4b9778590Fa3CAB3aC9e2168;
//     pools["WBTC/ETH3"]  = 0xCBCdF9626bC03E24f779434178A73a0B4bad62eD;

//     Arbitrum
//     pools["USDC/ETH05"] = 0xC31E54c7a869B9FcBEcc14363CF510d1c41fa443;
//     pools["USDC/ETH3"]  = 0x17c14D2c404D167802b16C450d3c99F88F2c4F4d;
//     pools["WBTC/ETH05"] = 0x2f5e87C9312fa29aed5c179E456625D79015299c;
//     pools["WBTC/ETH3"]  = 0x149e36E72726e0BceA5c59d40df2c43F60f5A22D;
//     pools["GMX/ETH1"]   = 0x80A9ae39310abf666A87C743d6ebBD0E8C42158E;
