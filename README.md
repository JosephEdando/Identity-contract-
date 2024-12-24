Overview

The IdentityContract is a decentralized smart contract built with Solidity that enables identity registration, verification, and revocation. It allows for the decentralized management of identities and verifiers, with access controls to ensure only authorized entities perform sensitive actions.

Features

Core Functionalities

Identity Registration:

Users can register their identities by providing:
Email
First Name
Last Name
Verification Document
Registered identities are stored in a mapping and can be retrieved later.
Identity Verification:

Authorized verifiers can mark a user’s identity as verified.
Identity Revocation:

Authorized verifiers can revoke an identity and mark it as invalid.
Verifier Management:

The contract manager can add new verifiers.
Verifiers can remove other verifiers from the authorized list.
Access Control:

Only verifiers and the contract manager can perform restricted actions.
Regular users can only register their own identities.
Retrieve All Identities:

Verifiers can access a list of all registered identities.
Contract Details
Data Structures
Identity Struct:

Stores the following:
owner: Address of the identity owner.
email: Email address of the user.
first_name: First name of the user.
last_name: Last name of the user.
verificationDoc: Document provided for identity verification.
isVerified: Boolean indicating if the identity is verified.
isRevoke: Boolean indicating if the identity is revoked.
Mappings:

userIdentity: Links user addresses to their identities.
verifiers: Tracks addresses authorized to verify identities.
Access Control
Contract Manager:
The deployer of the contract.
Responsible for managing verifiers.
Verifiers:
Authorized entities that can verify or revoke identities.
Users:
Regular accounts that can register their identities.
Security Notes
Role-Based Access Control:
Sensitive operations are restricted to authorized roles.
Data Privacy:
Personal details are stored on-chain, so sensitive information should be hashed off-chain before registration.
Future Enhancements
Off-Chain Verification:
Use decentralized storage (e.g., IPFS) for verification documents.
Role Management:
Allow the contract manager to delegate verifier management to other trusted roles.
Integration:
Extend functionality to interact with external identity standards like W3C DIDs.
