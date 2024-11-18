# Parking Lot Smart Contract

A simple Solidity contract that allows setting a state value with validation and performing safe division between two numbers. It ensures the new value is positive and different from the current one, and that division operations are only performed when the denominator is non-zero and divisible.

## Description
This Solidity smart contract allows users to interact with a digital parking lot by reserving and releasing parking slots. The contract manages the availability of parking slots, enabling users to reserve a slot, release it once they are done, check the availability of a specific slot, and stop a slot from being used in case of an emergency. The contract ensures that only valid slots are interacted with and that actions like reserving and releasing are done by the rightful user.

*Reserve a Slot: Users can reserve a parking slot if it is available.
*Release a Slot: Users can release a slot if they reserved it.
*Check Slot Availability: Users can check if a particular slot is available or reserved.
*Emergency Stop: Admin can stop a slot from being used in an emergency, provided the slot is not already reserved.

## Getting Started
### Executing Program
To run this program, you can use Remix, an online IDE for Solidity development. Follow the steps below to execute the program:

Visit the Remix IDE website at Remix Ethereum.
Create a new file by clicking on the "+" icon in the left-hand sidebar, and save the file with a .sol extension (e.g., smart-Contract.sol).
Copy and paste the following code into your new file:
```javascript
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
```
To compile the code, go to the "Solidity Compiler" tab in the left-hand sidebar. Set the "Compiler" version to 0.8.18, then click on the "Compile myToken.sol" button.
Once the code is compiled, navigate to the "Deploy & Run Transactions" tab. Select the myToken contract from the dropdown menu, and click on the "Deploy" button.
After deployment, you can mint and burn tokens by interacting with the mint and burn functions:
To mint tokens, enter the recipient's address and the amount to mint.
To burn tokens, input the address and the amount of tokens to burn (ensuring the address has enough tokens).
## Authors
Metacrafter Charles_shiro


## License
This project is licensed under the MIT License - see the LICENSE.md file for details.
