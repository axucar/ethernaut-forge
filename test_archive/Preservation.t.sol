// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "src/AttackPreservation.sol";

contract TestPreservation is Test {
    AttackPreservation x;
    function setUp() public {}

    function testPreservation() public{
        
        vm.startPrank(0x9bdcf9696e273aFd83992b1Fb5672A70532ca9E1,0x9bdcf9696e273aFd83992b1Fb5672A70532ca9E1);        
        IPreservation p = IPreservation(0x88e3A3Af63d5EAA1741E2F3ED2801c56B38Ea240); //access p via interface abi
        x = new AttackPreservation(0x88e3A3Af63d5EAA1741E2F3ED2801c56B38Ea240); 
        console.log(p.owner());
        vm.stopPrank();
    }
}

