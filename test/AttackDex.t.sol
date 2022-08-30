// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "src/AttackDex.sol";

contract TestShop is Test {
    AttackDex x;
    function setUp() public {}

    function testShop() public{
        
        vm.startPrank(0x9bdcf9696e273aFd83992b1Fb5672A70532ca9E1);
        address victim = 0x7AfD1F1f0C70F0456BD7A1D76885D1d0a615fD59;                
        x = new AttackDex(victim);
        x.attack();
        vm.stopPrank();
    }
}

