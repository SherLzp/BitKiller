pragma solidity ^0.4.2;

contract PushStudy{

    address public owner;
    
    uint fee = 1 ether;

    function signup() public payable returns(bool){
        require(msg.sender.balance >= fee,"余额不足");
        return true;
    }

    function PushStudy() public payable{
        owner = msg.sender;
    }


}