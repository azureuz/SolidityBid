pragma solidity ^0.7.0;

contract votingmodified{
    
        struct voterDetails {
        uint256 voterID;
        string voterChoice;
        bool voteStatus;
        address voterAddress;
    }
    
        struct governmentCandidates {
        string candidateName;
        string candidatePartyName;
        uint256 votecount;
    }
    
    constructor(){
        initializeCandidate();
    }
    
             uint256 count = 0;
             string constant defaultVote = 'still to vote';
             mapping(address=> voterDetails) public voter;
             mapping(string=> governmentCandidates) public candidate;
     
        function addVoter() external returns(uint256){
        voter[msg.sender] = voterDetails(count,defaultVote,false,msg.sender);
        count++;
        return count-1;
    }
    
        function initializeCandidate() internal {
            candidate["Trump"]= governmentCandidates("Trump","Republican",count);
            candidate["Biden"]= governmentCandidates("Biden","Democrat",count);
        }
        
        function vote(string memory candidateChoice) external {
            require(voter[msg.sender].voteStatus==false);
            candidate[candidateChoice].votecount++;
            voter[msg.sender].voterChoice=candidateChoice;
            voter[msg.sender].voteStatus=true;
        }
    
    
    
    
    
    
}
