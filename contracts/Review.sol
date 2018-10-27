pragma solidity ^0.4.2;

contract Review {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount_yes;
        uint voteCount_no;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;
    // Store Candidates
    // Fetch Candidate
    mapping(uint => Candidate) public candidates;
    // Store Candidates Count
    uint public candidatesCount;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    function Review () public {
        addCandidate("It's My Answer");
    }

    function addCandidate (string _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0,0);
    }

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        if(_candidateId == 1){
            candidates[1].voteCount_yes ++;
        }else{
            candidates[1].voteCount_no ++;
        }

        // trigger voted event
        votedEvent(_candidateId);
    }

}