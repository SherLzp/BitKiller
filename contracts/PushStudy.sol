pragma solidity ^0.4.2;

contract PushStudy{

    //Model a Candidate
    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }

    address public owner;

    modifier restricted(){
        if(msg.sender == owner)
        _;
    }

    //Store Account that have voted
    mapping(address => bool) public voters;
    //Store Candidates
    //Fetch Candidates
    mapping(uint => Candidate) public candidates;

    mapping(address => uint) public balances;
    
    uint fee = 1 ether;

    //Store Candidate Counts
    uint public candidatesCount;

    function signup() public payable{
        require(msg.sender.balance >= fee,"余额不足");
        if(msg.sender.balance > fee){
            msg.sender.transfer(fee);
        }
        
    }

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    function PushStudy() public payable{
        owner = msg.sender;
    }

    function addCandidate(string _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount,_name,0);
    }

    function vote(uint _candidateId) public {
        //require that they haven't voted before
        require(!voters[msg.sender],"The voter has voted");

        //require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount,"Invalid candidate");
        //record that voter has voted
        voters[msg.sender] = true;

        //update candidate vote count
        candidates[_candidateId].voteCount ++;

        //trigger voted event
        votedEvent(_candidateId);
    }


}

