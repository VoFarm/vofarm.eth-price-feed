// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.6;

import '@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol';
// import 'https://raw.githubusercontent.com/Uniswap/v3-core/main/contracts/interfaces/IUniswapV3Pool.sol'

contract PriceFeed{ // should be responsible 

    mapping (string => address) private pools;

    mapping (string => address);

    // Arb-ChainID = 42161
    constructor(string memory _name)
    {

        uint256 id = getChainID();
        if (id == 1) // mainnet
        {
            pools["USDC/ETH05"] = 0x88e6A0c2dDD26FEEb64F039a2c41296FcB3f5640;
            pools["USDC/ETH3"]  = 0x8ad599c3A0ff1De082011EFDDc58f1908eb6e6D8;
            pools["DAI/USDC01"]  = 0x5777d92f208679DB4b9778590Fa3CAB3aC9e2168;
            pools["WBTC/ETH3"]  = 0xCBCdF9626bC03E24f779434178A73a0B4bad62eD;
        }
        
        if (id == 42161) // arbitrum
        {
            pools["USDC/ETH05"] = 0xC31E54c7a869B9FcBEcc14363CF510d1c41fa443;
            pools["USDC/ETH3"]  = 0x17c14D2c404D167802b16C450d3c99F88F2c4F4d;
            pools["WBTC/ETH05"] = 0x2f5e87C9312fa29aed5c179E456625D79015299c;
            pools["WBTC/ETH3"]  = 0x149e36E72726e0BceA5c59d40df2c43F60f5A22D;
            pools["GMX/ETH1"]   = 0x80A9ae39310abf666A87C743d6ebBD0E8C42158E;
        }

        pool = ;

    }

    function getPrice(uint chainId, string _name) {
        IUniswapV3Pool pool = IUniswapV3Pool(pools[_name]);
    }

    function addPoolContractMapping(uint chainId, string _name, address uniswapLiquidityPoolAddress) {

    }

    function getChainID() private view returns(uint256)
    {
        uint256 id;
        assembly {
            id := chainid()
        }
        return id;
    }

    function getX96() private view returns(uint160)
    {

        (uint160 sqrtPriceX96, 
        int24 tick,
        uint16 observationIndex,
        uint16 observationCardinality,
        uint16 observationCardinalityNext,
        uint8 feeProtocol,
        bool unlocked ) = pool.slot0();

        return sqrtPriceX96; // token price ratio token 0 / token 1
    }

    function getPrimaryToken() public view returns(address)
    {
        return pool.token0();
    }

    function getSecondaryToken() public view returns(address)
    {
        return pool.token1();
    }

    function getPrimaryPrice() public view returns(uint256)
    {
        return ((uint256(getX96()) ** 2) / (2 ** 192));
    }

    function getSecondaryPrice() public view returns(uint256)
    {
        return (2 ** 192 * (10**16)) / (uint256(getX96()) ** 2);
    }

}
