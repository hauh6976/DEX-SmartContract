pragma solidity ^0.8.0;

interface IUniswapV2Router02 {
    function swapExactTokensForTokens(
        uint amountIn, 
        uint amountOutMin, 
        address[] calldata path,
        address to, 
        uint deadline
    ) external returns (uint[] memory amounts);
}

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
}

contract TokenSwapper {
    address public uniswapRouter;
    address public tokenA;
    address public tokenB;
    
    constructor(address _uniswapRouter, address _tokenA, address _tokenB) {
        uniswapRouter = _uniswapRouter;
        tokenA = _tokenA;
        tokenB = _tokenB;
    }

    function swapTokens(uint amountIn, uint amountOutMin) public {
        IERC20(tokenA).approve(uniswapRouter, amountIn);
        address[] memory path = new address[](2);
        path[0] = tokenA;
        path[1] = tokenB;
        uint deadline = block.timestamp + 3600;
        IUniswapV2Router02(uniswapRouter).swapExactTokensForTokens(
            amountIn,
            amountOutMin,
            path,
            msg.sender,
            deadline
        );
    }
}
