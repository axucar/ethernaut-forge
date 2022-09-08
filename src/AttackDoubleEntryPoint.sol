pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

interface ICryptoVault {
    function underlying() external returns(IERC20);
    function sweepToken(IERC20 token) external; 
}

interface IForta {
    function setDetectionBot(address detectionBotAddress) external;
    function notify(address user, bytes calldata msgData) external;
    function raiseAlert(address user) external;
}

interface IDoubleEntryPoint {
    function forta() external returns(IForta);
    function cryptoVault() external returns(address);
}

interface DelegateERC20 {
  function delegateTransfer(address to, uint256 value, address origSender) external returns (bool);
}

interface ILegacyToken {
    function delegateToNewContract(DelegateERC20 newContract) external;    
    function owner() external returns(address);
    function delegate() external returns(DelegateERC20);

}

contract DetectionBot {
    address refUser;
    bytes refMsgData;
    constructor (address _refUser, bytes memory _refMsgData) {
        refUser = _refUser;
        refMsgData = _refMsgData;
    }

    function handleTransaction(address user, bytes calldata msgData) public {        
        bytes memory functionSig = msgData[:4];
        ( , , address origSender) = abi.decode(msgData[4:],(address,uint256,address));
        
        //check that origSender is the CryptoVault contract
        if ((origSender==refUser) && (keccak256(functionSig) == keccak256(refMsgData))) {
            //the msg.sender (caller of DetectionBot.handleTransaction) is a Forta contract            
            IForta forta = IForta(msg.sender);
            forta.raiseAlert(user);
        }
    }
}

