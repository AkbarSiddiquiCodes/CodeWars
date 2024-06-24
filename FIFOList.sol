// Let's create a smart contract with a FIFO queue-like interface that may serve as a simple waiting list.

// Requirements:
// The user should be able to add themselves (i.e. their address) to the end of the queue by calling the push method. It should take no arguments.
// A deposit of at least 0.1 ether is required for a push operation to succeed. The deposit should be kept by the contract and be returned to user on pop (see point 5.)
// The contract should keep the number of items in the queue and serve it via size() method.
// All items in the queue should be accessible via get method. It should take the index of an item as an argument and return the tuple containing address and deposit size.
//  Trying to get an item from an empty queue should revert. Getting an item with non-existing index should also revert.
// Calling the pop method should remove an item from the front of the queue. It should be callable only by the contract owner. Upon calling the method the deposit made by
//  the user on push should be returned to them in the exact same amount. Popping an empty queue should revert.
// The following gas limits should be met:
// operation	gas limit
// push	75000
// pop	61000
// Summary:
// Your task is to implement four interface methods according to the requiremens:

// push() external payable
// pop() external
// size() external view returns(uint256)
// get(uint256 _index) external view returns(address, uint256)
// Keeping the function signatures as specified above is also a requirement.


// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "hardhat/console.sol";

contract WaitingList {
    struct Item {
      address payable sender;
      uint deposit;
    }
    mapping(uint256 => Item) queue;
    uint256 first = 1;
    uint256 last = 0;
    address immutable owner;

    constructor() {
        owner = msg.sender;
    }

    /// @dev Push the sender's address to the end of the queue.
    function push() external payable {
        assert(msg.value >= 0.1 ether);
        last++;
        queue[last] = Item({
          sender: payable(msg.sender),
          deposit: msg.value
        });
    }

    /// @dev Pop the first item from the front of the queue and return the deposit to the user. Callable only by owner.
    function pop() external {
        assert(msg.sender == owner);
        assert(last >= first);
        Item memory item = queue[first];
        delete queue[first];
        first += 1;
        
        item.sender.transfer(item.deposit);
    }

    /// @dev Return the number of elements currently in the queue.
    /// @return uint256 current size of the queue
    function size() external view returns(uint256) {
        return last + 1 - first;
    }

    /// @dev Get any element of the queue by index.
    /// @param _index - index of the element in the queue
    /// @return address - address of the user
    /// @return uint256 - deposit amount
    function get(uint256 _index) external view returns(address, uint256) {
        assert(last >= first + _index);
        Item memory item = queue[first + _index];
        return (item.sender, item.deposit);
    }
}