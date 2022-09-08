// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "src/AttackMotorbike.sol";

contract TestMotorbike is Test {
    AttackMotorbike x;    
    function setUp() public {}

    function testMotorbike() public{
        address player = 0x9bdcf9696e273aFd83992b1Fb5672A70532ca9E1;
        vm.startPrank(player);   //sets msg.sender for contract calls; e.g. as if player is calling the contracts                

        //address of Engine (find using cast storage <challenge_addr> <_IMPLEMENTATION_SLOT>)
        address victim = 0x56B80b55e3E1C334F37628c8D5897F8B9d4063AA; 
        x = new AttackMotorbike(victim);                                   
        x.attack();
        vm.stopPrank();
    }
}

