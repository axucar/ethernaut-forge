// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "src/AttackNaughtCoin.sol";

contract TestNaughtCoin is Test {
    AttackNaughtCoin x;
    function setUp() public {}

    function testNaughtCoin() public{
        //require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == uint64(0) - 1);        
        vm.startPrank(0x9bdcf9696e273aFd83992b1Fb5672A70532ca9E1);
        x = new AttackNaughtCoin(0x34900E99A860401b0770934aD430f62fA9eeB03c);
        vm.stopPrank();
    }
}

