pragma solidity ^0.4.0;

/// @title Vote System - Solidity Smart-contract
/// @author Alexia Guillermond & Sajirami Selvaratnam

contract Ballot {

    struct Voter {
        bool voted;
        address id;
        uint vote;
    }
    
    struct Proposal {
        bytes32 name;
        address author;
        uint voteCount;
    }
    
    address public chairperson;
    mapping(address => Voter) voters;
    Proposal[]  proposals;
    uint currentTime = block.number;
    uint endTime;

    
    // @notice: voter gives a vote to a proposal
    // @param: Take in argument the proposal
    function giveVote(uint proposal)
    {
        if(currentTime<endTime){
            if(voters[msg.sender].id != proposals[proposal].author && voters[msg.sender].voted !=true){
                voters[msg.sender].voted = true;
                proposals[proposal].voteCount++;
                voters[msg.sender].vote = proposal;
            }
        }
    }

    // @notice: add a new voter to the voters list, each voter has a proper single address
    // @param: take in argument the address of a voter already registered to verify if the address exists already or not
    //         (we should run through voters list and get their id)
    function addVoter(address id) {
        Voter newVoter;
        if(msg.sender!= id){
            newVoter.voted = false;
            newVoter.id = msg.sender;
            newVoter.vote = 0;
        }
    }

    // @notice: add a new proposal to proposals tab, the new proposal must not exist yet
    // @param: name of the new proposal
    function addProposal(bytes32 newProposal) {
        for(uint i = 0; i < proposals.length ; i++)
        {
            if(newProposal != proposals[i].name){ 
                proposals.push( Proposal({
                    name : newProposal , 
                    author: msg.sender, 
                    voteCount : 0 
                }));
            }
            else{
                throw;
            }
        }
    }
    
    // @notice: count votes and return the winning proposal
    function winningProposal() constant returns (uint,bytes32){
        if(currentTime >= endTime){
            uint winningVoteCount = 0;
            for (uint i = 0; i < proposals.length; i++) {
                if (proposals[i].voteCount > winningVoteCount) {
                    winningVoteCount = proposals[i].voteCount;
                    return (i,proposals[i].name);
                }
            }
        }
    }
    
}
