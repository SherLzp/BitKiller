pragma solidity ^0.4.2;

contract PushStudy{

    address public owner;
    
    uint fee = 1 ether;

    function signup() public payable{
        require(msg.sender.balance >= fee,"余额不足");
    }

    function PushStudy() public payable{
        owner = msg.sender;
    }


}