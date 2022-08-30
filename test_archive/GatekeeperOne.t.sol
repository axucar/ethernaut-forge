// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "src/AttackGatekeeperOne.sol";

contract TestGatekeeperOne is Test {
    AttackGatekeeperOne gkp;
    function setUp() public {
        //gkp = AttackGatekeeperOneExact(0x03dEaE783551a0C99280D9044Df1f92b9e3B3232);
        gkp = new AttackGatekeeperOne(0x590aAf34f517B1ADc569bfB48420227FE0D0ceD8);
    }

    function testGatekeeper() public{
        bytes8 _key = 0xffffffff0000a9E1; 
        vm.startPrank(0x9bdcf9696e273aFd83992b1Fb5672A70532ca9E1,0x9bdcf9696e273aFd83992b1Fb5672A70532ca9E1);

        console.logBytes8(_key);
        console.log("uint16(uint64(_key)): %s", uint16(uint64(_key)) );
        console.log("uint32(uint64(_key)): %s", uint32(uint64(_key)) );
        console.log("uint64(_key): %s", uint64(_key));
        console.log("uint16(tx.origin): %s", uint16(uint160(0x9bdcf9696e273aFd83992b1Fb5672A70532ca9E1)));

        gkp.attack(_key,0);
        vm.stopPrank();
    }
}

