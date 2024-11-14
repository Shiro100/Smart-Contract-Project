// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract smartContract {
    uint public value;

    function setValue(uint _value) public {
        assert(_value != value);  // Assert that the new value is different from the current one.
        
        require(_value > 0, "Value must be greater than 0.");  // Ensure the value is greater than zero.
        
        value = _value;
    }

    function performDivision(uint _numerator, uint _denominator) public pure returns (uint) {
        require(_denominator != 0, "Cannot divide by zero.");  // Prevent division by zero.

        if (_numerator % _denominator != 0) {
            revert("Numerator must be divisible by denominator.");  // Ensure divisibility.
        }

        return _numerator / _denominator;
    }
}
