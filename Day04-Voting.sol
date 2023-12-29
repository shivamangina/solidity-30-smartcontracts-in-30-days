// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Voting {
    struct Voter {
        bool isEligible;
        bool voted;
        uint256 votedTo; // index of the proposal
    }
    struct Proposal {
        bytes32 name;
        uint256 voteCount;
    }

    address public chairperson;
    bool public votingInProgress = false;
    mapping(address => Voter) public voters;
    Proposal[] public proposals;
    bytes32 winningProposal;

    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;

        for (uint256 i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
        }
    }

    modifier onlyChairperson() {
        require(msg.sender == chairperson);
        _;
    }

    function startElection() public onlyChairperson {
        votingInProgress = true;
    }

    function stopElection() public onlyChairperson {
        votingInProgress = false;
        uint256 votingCount = 0;
        for (uint256 i = 0; i < proposals.length; i++) {
            if (votingCount < proposals[i].voteCount) {
                votingCount = proposals[i].voteCount;
                winningProposal = proposals[i].name;
            }
        }
    }

    function vote(uint256 proposal) public {
        Voter storage voter = voters[msg.sender];
        require(voter.voted, "Already Voted");
        require(!voter.isEligible, "Not Eligible");

        voter.voted = true;
        voter.votedTo = proposal;
        proposals[proposal].voteCount++;
    }

    function giveRightToVote(address voter) public onlyChairperson {
        voters[voter].isEligible = true;
        voters[voter].voted = false;
    }
}
