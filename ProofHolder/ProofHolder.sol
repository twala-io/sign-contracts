pragma solidity ^0.6.0;

import "./Ownable.sol";

contract ProofHolder is Ownable {
    struct Proof {
        bytes32 hash;
        string root;
        string timestamp;
        bool isSet;
    }

    mapping (bytes32 => Proof) proofMapping;

    constructor() public Ownable() {}

    /**
     * Retrieve a proof from the smart contract.
     *
     **/
    function retrieveProof(bytes32 _hash) public view returns(bytes32, string memory, string memory) {
        require(proofMapping[_hash].isSet, "Proof does not exist");
        return(proofMapping[_hash].hash, proofMapping[_hash].root, proofMapping[_hash].timestamp);
    }

    /**
     * Record a new proof to the smart contract.
     *
     **/
    function recordProof(bytes32 _hash, string memory _root, string memory _timestamp) public onlyOwner {
        require(!proofMapping[_hash].isSet, "Proof already exists");
        proofMapping[_hash].hash = _hash;
        proofMapping[_hash].root = _root;
        proofMapping[_hash].timestamp = _timestamp;
        proofMapping[_hash].isSet = true;
    }
}