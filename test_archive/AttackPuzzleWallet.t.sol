// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "src/AttackPuzzleWallet.sol";

contract TestPuzzleWallet is Test {
    AttackPuzzleWallet x;
    IPuzzleWallet pw;
    function setUp() public {}

    function testPuzzleWallet() public{
        address player = 0x9bdcf9696e273aFd83992b1Fb5672A70532ca9E1;
        vm.startPrank(player);   //sets msg.sender for contract calls; e.g. as if player is calling the contracts                

        address victim = 0x5984e653A50261454a25c3458a4aD4858Ec97A6b;                
        x = new AttackPuzzleWallet(victim);           
                
        (bool sent, ) = address(x).call{value:0.001 ether}(""); //send eth to attacker contract
        require(sent, "failed to send ether");
                
        x.attack();
        vm.stopPrank();
    }
}

