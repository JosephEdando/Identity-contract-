// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;


contract DecentralizedIdentity {
    // Struct for identity
    struct Identity {
        string name;
        string email;
        string verificationDocument;
        bool isVerified;
        bool isRevoked;
        address owner;
    }

    // State variables
    mapping(address => Identity) private identities;
    mapping(address => bool) private authorizedVerifiers;

    // store all registered identities
    Identity[] public allRegisterefIdentities;

    address public contractOwner;

    // Events
    event IdentityRegistered(address indexed user, string name, string email);
    event IdentityVerified(address indexed user, address indexed verifier);
    event IdentityRevoked(address indexed user, address indexed revoker);
    event VerifierAdded(address indexed verifier);
    event VerifierRemoved(address indexed verifier);

    // Constructor
    constructor() {
        contractOwner = msg.sender;
    }

    // Modifiers
    modifier onlyContractOwner() {
        require(msg.sender == contractOwner, "Only the contract owner can perform this action.");
        _;
    }

    modifier onlyIdentityOwner(address user) {
        require(identities[user].owner == msg.sender, "Only the identity owner can perform this action.");
        _;
    }

    modifier onlyVerifier() {
        require(authorizedVerifiers[msg.sender], "Only authorized verifiers can perform this action.");
        _;
    }

    
    //  function to register Identity
    function registerIdentity(
        string memory _name,
        string memory _email,
        string memory _verificationDocument
    ) external {
        require(identities[msg.sender].owner == address(0), "Identity already registered.");

        Identity memory newIdentity= Identity({
            name: _name,
            email: _email,
            verificationDocument: _verificationDocument,
            isVerified: false,
            isRevoked: false,
            owner: msg.sender
        });

        identities[msg.sender]=newIdentity;
        allRegisterefIdentities.push(newIdentity);
            
        emit IdentityRegistered(msg.sender, _name, _email);
    }


     //  function to verify Identity

    function verifyIdentity(address user) external onlyVerifier {
        require(identities[user].owner != address(0), "Identity not registered.");
        require(!identities[user].isVerified, "Identity already verified.");
        require(!identities[user].isRevoked, "Identity is revoked.");

        identities[user].isVerified = true;

        emit IdentityVerified(user, msg.sender);
    }

    
     //  function to Revoke Identity

    function revokeIdentity(address user) external onlyVerifier {
        require(identities[user].owner != address(0), "Identity not registered.");
        require(!identities[user].isRevoked, "Identity already revoked.");

        identities[user].isRevoked = true;
        identities[user].isVerified = false;

        emit IdentityRevoked(user, msg.sender);
    }

       //  function to retrieve Identity

    function getIdentity(address user)
        external
        view
        returns (Identity memory )
    {
        return identities[user];
        
    }
    // function to get all identities
    function getAllRegisterefIdentities() public view returns (Identity[] memory){
        return allRegisterefIdentities;
    }
   
     //  function to Adds a new verifier Identity

    function addVerifier(address verifier) external onlyContractOwner {
        require(!authorizedVerifiers[verifier], "Verifier already authorized.");
        authorizedVerifiers[verifier] = true;

        emit VerifierAdded(verifier);
    }

  
     //  function to Removes an existing verifier Identity

    function removeVerifier(address verifier) external onlyContractOwner {
        require(authorizedVerifiers[verifier], "Verifier not authorized.");
        authorizedVerifiers[verifier] = false;

        emit VerifierRemoved(verifier);
    }
}
