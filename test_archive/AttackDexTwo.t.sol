// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "src/AttackDexTwo.sol";

contract TestDexTwo is Test {
    AttackDexTwo x;
    IDex d;
    function setUp() public {}

    function testDexTwo() public{
        
        vm.startPrank(0x9bdcf9696e273aFd83992b1Fb5672A70532ca9E1);
        address victim = 0xD320cFB100c9E2f73A8E00EF74be2A24c1Ff7275;                
        x = new AttackDexTwo(victim);                
        x.attack();
        vm.stopPrank();
    }
}

