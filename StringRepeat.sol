//Write a function that accepts an integer n and a string s as parameters, and returns a string of s repeated exactly n times

//Examples (input -> output)
//6, "I"     -> "IIIIII"
//5, "Hello" -> "HelloHelloHelloHelloHello"


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract Repeater {
  function multiply(uint8 repeat, string memory pattern) public pure returns (string memory) {
    string memory script = "";
        for (uint8 i = 0; i < repeat; i++) {
            script = string.concat(script, pattern);
        }
    return script;
  }
}
