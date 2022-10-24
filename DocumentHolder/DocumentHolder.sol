pragma solidity ^0.6.0;

import "./Ownable.sol";

contract DocumentHolder is Ownable {
    struct Document {
        bytes32 hash;
        string category;
        address owner;
        string evidence;
        string timestamp;
        bool isSet;
    }

    mapping (bytes32 => Document) documentMapping;
    
    constructor() public Ownable() {}

    /**
     * Retrieve a document from the smart contract.
     *
     **/
    function retrieveDocument(bytes32 _hash) public view returns(bytes32, string memory, address, string memory, string memory) {
        require(documentMapping[_hash].isSet, "Document does not exist");
        return(documentMapping[_hash].hash, documentMapping[_hash].category, documentMapping[_hash].owner, documentMapping[_hash].evidence, documentMapping[_hash].timestamp);
    }

    /**
     * Record a new document to the smart contract.
     *
     **/
    function recordDocument(bytes32 _hash, string memory _category, address _owner, string memory _evidence, string memory _timestamp) public onlyOwner {
        require(!documentMapping[_hash].isSet, "Document already exists");
        documentMapping[_hash].hash = _hash;
        documentMapping[_hash].category = _category;
        documentMapping[_hash].owner = _owner;
        documentMapping[_hash].evidence = _evidence;
        documentMapping[_hash].timestamp = _timestamp;
        documentMapping[_hash].isSet = true;
    }
}
