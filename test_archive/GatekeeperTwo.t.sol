// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "src/AttackGatekeeperTwo.sol";

contract TestGatekeeperTwo is Test {
    AttackGatekeeperTwo gkp;
    function setUp() public {
        gkp = new AttackGatekeeperTwo(0xfC65cd45d9B0A1F24D4603a8C045Efad7e2602f0);
    }

    function testGatekeeper() view public{
        //require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == uint64(0) - 1);
        bytes8 _key = bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ (type(uint64).max)); 
        uint64 a = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 b = uint64(_key);
        uint64 c = a ^ b;
        console.logBytes8(_key);
        console.log("a:%s",a);
        console.log("b:%s",b);
        console.log("c:%s",c);
        console.log("uint64(0) - 1:%s", type(uint64).max);

        gkp.checkExtCode();
    }
}

