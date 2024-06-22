// This code does not execute properly. Try to figure out why.


// SPDX-License-Identifier: BSD-2-Clause
pragma solidity ^0.8.0;

contract DummyToken {
  function multiply(int a, int b) public pure returns (int) {
    return a * b;
  }
}