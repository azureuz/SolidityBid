pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

contract Voting{
   
   
    struct voterDetails {
        uint256 voterID;
        string voterChoice;
        bool voteStatus;
        address voterAddress;
    }

    struct governmentCandidates {
        string candidateName;
        string candidatePartyName;
        address payable candidateFundraiserAddress;
    }
    
    struct candidateVotes {
        address payable candidateFundraiserAddress;
        string candidateName;
        uint256 voteCount;
    }
    
    governmentCandidates[] public gc;
   
    string[] public candidateNameArray;
    
    uint256 count = 0;
    string constant defaultVote = 'still to vote';
    //Mappings
    mapping(address=> voterDetails) public voter;
    mapping(string=> candidateVotes) public votes; 
    mapping(string=> governmentCandidates) public candidate;
    
    function addVoter() external returns(uint256){
        voter[msg.sender] = voterDetails(count,defaultVote,false,msg.sender);
        count++;
        return count-1;
    }
    
    function addCandidate(address payable _candidateAddress, string memory _candidateName, string memory _candidatePartyName) external{
        uint256 partyVoteCount=0;
        candidate[_candidateName] = governmentCandidates(_candidateName,_candidatePartyName,_candidateAddress);
        votes[_candidateName]=candidateVotes(_candidateAddress,_candidateName,partyVoteCount);
        governmentCandidates memory m=governmentCandidates(_candidateName,_candidatePartyName,_candidateAddress);
        gc.push(m);
        candidateNameArray.push(_candidateName);
    }    
    
    function vote(string memory _voterChoice) external{
        
        voter[msg.sender].voterChoice = _voterChoice;
        votes[_voterChoice].voteCount++;
        voter[msg.sender].voteStatus = true;
    }
    
    function raiseFunds(string memory _voterChoice) external payable returns(address payable){
        address payable candidateAddress = candidate[_voterChoice].candidateFundraiserAddress;
        candidateAddress.transfer(msg.value);
        return candidateAddress;
         
    }
    
    
    function candidateDetails() external view returns(governmentCandidates[] memory){
        return gc;    
    }
    
    function getAllCandidateNames() public view returns (string[] memory){
        return candidateNameArray;
    }
    

}


