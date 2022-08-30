// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "src/AttackAlienCodex.sol";

contract TestAlienCodex is Test {
    AttackAlienCodex x;
    function setUp() public {}

    function testAlienCodex() public{
        
        vm.startPrank(0x9bdcf9696e273aFd83992b1Fb5672A70532ca9E1,0x9bdcf9696e273aFd83992b1Fb5672A70532ca9E1);                        
        x = new AttackAlienCodex(0xdE24F6C3E55915Eac4cB7c1bD0F10A14801EC123); 
        IAlienCodex a = IAlienCodex(0xdE24F6C3E55915Eac4cB7c1bD0F10A14801EC123);
        console.log(a.owner());
        x.attack();
        console.log(a.owner());
        vm.stopPrank();
    }
}

