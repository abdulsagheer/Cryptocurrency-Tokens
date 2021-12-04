// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

// Developed an Ethereum smart contract The contract allows only to create new coins(different issuance schemas are possible).
//Anyone can send coins to each other without a need for registering with a username and password, all you need is an Ethereum Keypair.

contract Coin {
    // keyword "public" make variables accessible from other contract.
    address public minter;
    mapping(address => uint) public balances;

    // Event allow clients to react to specific contract changes you declare.
    // Even is an inheritable member of a contract. An event is emitted, it stores the arguements passed in transaction logs.
    // These logs are stored an blockchain and are accessible using address of the contract till the contract is present on the blockchain.
    event Sent(address from, address to, uint amount);

    // constructor only runs when we deploy contract is created.
    constructor() {
        minter = msg.sender;
    }

    // make new coins and send them to an addess only the woner can send these coins.
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    //Errors an amount of newly created coins to an address can only be called by the contract creator
    error insufficientBalance(uint requested, uint available); 

    //send any amount of coins to an existing address
    function send(address receiver, uint amount) public {

        // require amount to be greater than x = true and then run this.
        if(amount > balances[msg.sender])
            revert insufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
    
}