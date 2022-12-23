// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

// EVENTS
// FUNCTION MODIFIERS
// for loop

contract Voting {

    bool public votingInProgress = false;

    struct Voter {
        bool isEligible;
        bool voted;  // if true, that person already voted
        uint voteTo;   // index of the voted proposal
    }

    // This is a type for a single proposal.
    struct Proposal {
        bytes32 name;   // short name (up to 32 bytes)
        uint voteCount; // number of accumulated votes
    }

    address public chairperson;

    // This declares a state variable that
    // stores a `Voter` struct for each possible address.
    mapping(address => Voter) public voters;

    // A dynamically-sized array of `Proposal` structs.
    Proposal[] public proposals;

    /// Create a new ballot to choose one of `proposalNames`.
    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;


        voters[chairperson].isEligible = true;
        voters[chairperson].voted = false;

        // For each of the provided proposal names,
        // create a new proposal object and add it
        // to the end of the array.
        for (uint i = 0; i < proposalNames.length; i++) {
            
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }


     // Give `voter` the right to vote on this ballot.
    // May only be called by `chairperson`.
    function giveRightToVote(address voter) external {
        
        require(
            msg.sender == chairperson,
            "Only chairperson can give right to vote."
        );
        require(
            !voters[voter].voted,
            "The voter already voted."
        );
        voters[voter].voted = false;
    }

    function startElection() public  {
        // only chairman
        votingInProgress = true;

    }

    function vote(uint proposal) external {
        Voter storage sender = voters[msg.sender];
        require(!sender.isEligible, "Has no right to vote");
        require(!sender.voted, "Already voted.");
        sender.voted = true;
        sender.voteTo = proposal;

        // Increase the voteCount
        proposals[proposal].voteCount += 1;
    }

    ///  Computes the winning proposal taking all
    /// previous votes into account.
    function winningProposal() public view
            returns (uint winningProposal_)
    {
        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    // Calls winningProposal() function to get the index
    // of the winner contained in the proposals array and then
    // returns the name of the winner
    function endElection() external view
            returns (bytes32 winnerName_)
    {
        winnerName_ = proposals[winningProposal()].name;
    }


}