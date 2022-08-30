// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "src/AttackShop.sol";

contract TestShop is Test {
    AttackShop x;
    function setUp() public {}

    function testShop() public{
        
        vm.startPrank(0x9bdcf9696e273aFd83992b1Fb5672A70532ca9E1);
        address victim = 0x7a1B11d069a82A1B6610AbfB51C48e050ECE4332;                
        x = new AttackShop(victim);
        x.attack();
        vm.stopPrank();
    }
}

