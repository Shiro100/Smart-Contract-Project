// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ErrorHandlingExample {
    uint public storedValue;

    function updateValue(uint newValue) public {
        assert(newValue != storedValue); // Assert placed here
        storedValue = newValue;
    }

    function safeDivision(uint numerator, uint denominator) public pure returns (uint) {
        if (numerator % denominator != 0) {
            revert("Numerator is not divisible by the denominator."); // Revert placed here
        }
        
        require(denominator != 0, "Division by zero is not allowed."); // Require placed here
        return numerator / denominator;
    }
}
