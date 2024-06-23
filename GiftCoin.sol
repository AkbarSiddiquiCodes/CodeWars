// Hey there! This challenge is an introduction to Ethereum Smart Contracts! If you're unfamiliar with Ethereum or the blockchain in general, the internet is loaded with 
//  good resources. The Ethereum Whitepaper may be a good place to start to learn about both. Since the contract is written in Solidity, the Solidity Documentation is also
//  an important resource.

// For this challenge we're going to deploy a new currency to our blockchain! The contract has been already started for you. It contains a couple state variables: owner and
//  coins. The owner variable is a hexidecimal address that will correspond to the address on the blockchain of the account who deployed the smart contract. The coins are a
//  mapping of hexidecimal blockchain addresses to their corresponding amount of coins that they own.

// Challenge
// You'll need to complete the to TODOs in the code.

// Fill out the sendGift function. It should only send a gift if the account making the transaction has enough coins to cover the amount they plan to gift. Should have they 
//  have sufficient funds, the funds should be subtracted from that account and added to the beneficiary's account. Then we should broadcast the GiftSent event for logging
//  purposes and so applications can respond to these events.

// Complete the onlyOwner modifier. It is a modifier meant for the mintCoins function, which should only be allowed to be called by the owner of the contract. We can't just
//  let anyone create new gift coins!

// Happy Coding!


// SPDX-License-Identifier: BSD-2-Clause
pragma solidity ^0.8.0;

contract GiftCoin {
  // keep track of all the addresses that have coins
  mapping (address => uint) coins; 
  // keep track of who the owner of this contract is
	address public owner; 

  constructor() {
    // When this coin is initially deployed, we'll set that account to be the user
    // msg is a globally available variable that will tell us information about this current contract call 
    // https://solidity.readthedocs.io/en/develop/units-and-global-variables.html
    owner = msg.sender;
  }
  
  // This is an event we'll broadcast when a gift is successfully sent from one account to another
  event GiftSent(
      address from,
      address to,
      uint amount
  );
  
  function sendGift(address receiver, uint amount) public {
    if (coins[msg.sender] >= amount) {
    coins[receiver] += amount;
    coins[msg.sender] -= amount; 
    emit GiftSent(msg.sender, receiver, amount);
	}
  }
  
  // this function will create new coins and should be reserved for only the owner to call it
  function mintCoins(address target, uint256 mintedAmount) onlyOwner public {
		coins[target] += mintedAmount;
	}
  
	modifier onlyOwner {
    require (owner == msg.sender, "You are not an owner!");
    require(true); 
    _;
	}

  // returns the balance of the address in question
  function balanceOf(address addr) public view returns(uint) {
    return coins[addr];
  }
}
