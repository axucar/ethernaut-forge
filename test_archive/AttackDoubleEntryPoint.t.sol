// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "src/AttackDoubleEntryPoint.sol";

contract TestDoubleEntryPoint is Test {

    function setUp() public {}

    function testDoubleEntryPoint() public{
        address player = 0x9bdcf9696e273aFd83992b1Fb5672A70532ca9E1;
        vm.startPrank(player);   //sets msg.sender for contract calls; e.g. as if player is calling the contracts                
        
        address doubleEntryPointVictim = 0x285E3c984406d851012562dA0223AC7FE68043E7; 
        IDoubleEntryPoint dep = IDoubleEntryPoint(doubleEntryPointVictim);                
        address vaultAddress = dep.cryptoVault();
        console.log(vaultAddress);
        console.logBytes(abi.encodeWithSignature("delegateTransfer(address,uint256,address)"));
        console.log(address(dep.forta()));
        DetectionBot db = new DetectionBot(vaultAddress, abi.encodeWithSignature("delegateTransfer(address,uint256,address)"));
        dep.forta().setDetectionBot(address(db));
        
        //test sweeping Legacy token from cryptoVault
        //this should trigger "Alert has been triggered!"
        IERC20 legacy = IERC20(0x3f5CE1A15E37702E9e6395E7dd1BA9f68297dc4c);
        ICryptoVault(vaultAddress).sweepToken(legacy);

        vm.stopPrank();
    }
}

