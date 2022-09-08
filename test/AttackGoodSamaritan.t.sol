// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "src/AttackGoodSamaritan.sol";

contract TestGoodSamaritan is Test {

    function setUp() public {}

    function testGoodSamaritan() public{
        address player = 0x9bdcf9696e273aFd83992b1Fb5672A70532ca9E1;
        vm.startPrank(player);   //sets msg.sender for contract calls; e.g. as if player is calling the contracts                

        address victimAddress = 0xE4F82bf5B24aedc51f3c4e25F712C8074ddc7870;
        AttackGoodSamaritan x = new AttackGoodSamaritan(victimAddress);
        ICoin c = IGoodSamaritan(victimAddress).coin();
        console.log(c.balances(address(x))); //start with 0        
        x.attack();
        console.log(c.balances(address(x))); //end with 1000000        

        vm.stopPrank();
    }
}

