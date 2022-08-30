
pragma solidity ^0.8.0;
contract ForceSend {
    constructor (address payable _target) payable {
        require(msg.value>0);
        selfdestruct(_target);
    }
}
