// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// A simple voting contract where users can vote for registered candidates
contract BasicVoting {

    // Address of the contract admin (the account that deploys the contract)
    address public Admin;

    // Structure to store candidate details
    struct Candidate {
        uint id;            // Unique candidate ID
        string name;        // Candidate name
        uint voteCount;     // Number of votes received
    }

    // Runs once at deployment
    // Sets the deployer as the admin
    constructor() {
        Admin = msg.sender;
    }

    // Stores candidates using their ID as the key
    mapping(uint => Candidate) public candidatesMap;

    // Tracks how many candidates exist
    uint public candidateCount;

    // Tracks whether an address has already voted
    mapping(address => bool) hasVoted;

    // Tracks the total number of votes cast
    uint public totalVotes;

    // Allows only the admin to add a new candidate
    function addCandidate(string memory _name) public {
        require(msg.sender == Admin, "Cannot be accessed by non-admins");

        // Increment candidate count to generate a new ID
        candidateCount++;

        // Create and store the new candidate
        candidatesMap[candidateCount] = Candidate(candidateCount, _name, 0);
    }

    // Allows a user to vote for a candidate by ID
    function vote(uint _candidateId) public {
        // Prevent double voting
        require(hasVoted[msg.sender] == false, "User has already voted");

        // Ensure the candidate exists
        require(
            _candidateId > 0 && _candidateId <= candidateCount,
            "Invalid candidate"
        );

        // Mark the user as having voted
        hasVoted[msg.sender] = true;

        // Increment the candidate's vote count
        candidatesMap[_candidateId].voteCount++;

        // Increment total votes
        totalVotes++;
    }
}
