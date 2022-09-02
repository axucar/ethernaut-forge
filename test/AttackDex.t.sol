// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "src/AttackDex.sol";

contract TestDex is Test {
    AttackDex x;
    IDex d;
    function setUp() public {}

    function testShop() public{
        
        vm.startPrank(0x9bdcf9696e273aFd83992b1Fb5672A70532ca9E1);
        address victim = 0x23bd651A4C98f880F0F6f209B4dAf32b2392ddc9;                
        x = new AttackDex(victim);        
        d = IDex(victim);        

        //give allowance to attacker to move tokens from player to attacker
        d.approve(address(x), 9999);

        x.attack();
        vm.stopPrank();
    }
}

