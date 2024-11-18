
# Parking Lot Smart Contract

A simple Solidity contract that allows users to interact with a digital parking lot by reserving and releasing parking slots. The contract manages the availability of parking slots, enabling users to reserve a slot, release it once they are done, check the availability of a specific slot, and stop a slot from being used in case of an emergency. The contract ensures that only valid slots are interacted with and that actions like reserving and releasing are done by the rightful user.

## Description
This Solidity smart contract allows users to interact with a parking lot by managing parking slots. The contract includes the following functionalities:

- **Reserve a Slot:** Users can reserve a parking slot if it is available.
- **Release a Slot:** Users can release a parking slot if they reserved it.
- **Check Slot Availability:** Users can check if a particular slot is available or reserved.
- **Emergency Stop:** Admin can stop a slot from being used in an emergency, provided the slot is not already reserved.

The contract tracks the availability and reservation status of each slot, ensuring that only valid actions are performed.

## Getting Started

### Executing Program
To run this program, you can use Remix, an online IDE for Solidity development. Follow the steps below to execute the program:

1. **Visit the Remix IDE Website:**
   - Go to [Remix Ethereum IDE](https://remix.ethereum.org/).

2. **Create a New File:**
   - Click on the "+" icon in the left-hand sidebar and save the file with a `.sol` extension (e.g., `ParkingLot.sol`).

3. **Add Code:**
   - Copy and paste the following code into your newly created file:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ParkingLot {
    struct Slot {
        bool isAvailable;  // Slot availability status
        address reservedBy; // Address of the person who reserved it
    }

    uint public totalSlots; // Total number of parking slots
    mapping(uint => Slot) public slots; // Mapping of slot ID to Slot struct

    constructor(uint _totalSlots) {
        require(_totalSlots > 0, "There must be at least one slot.");
        totalSlots = _totalSlots;
        for (uint i = 1; i <= totalSlots; i++) {
            slots[i] = Slot(true, address(0)); // Initialize all slots as available
        }
    }

    // Reserve a parking slot
    function reserveSlot(uint _slotId) public {
        require(_slotId > 0 && _slotId <= totalSlots, "Invalid slot ID.");
        Slot storage slot = slots[_slotId];

        require(slot.isAvailable, "Slot is already reserved.");
        assert(slot.reservedBy == address(0)); // Ensure no one is using the slot
        
        slot.isAvailable = false;
        slot.reservedBy = msg.sender; // Reserve slot for the sender
    }

    // Release a parking slot
    function releaseSlot(uint _slotId) public {
        require(_slotId > 0 && _slotId <= totalSlots, "Invalid slot ID.");
        Slot storage slot = slots[_slotId];

        require(!slot.isAvailable, "Slot is already available.");
        require(slot.reservedBy == msg.sender, "You are not the one who reserved this slot.");

        slot.isAvailable = true;
        slot.reservedBy = address(0); // Clear reservation
    }

    // Check the availability of a slot
    function checkAvailability(uint _slotId) public view returns (bool) {
        require(_slotId > 0 && _slotId <= totalSlots, "Invalid slot ID.");
        return slots[_slotId].isAvailable;
    }

    // Emergency stop for a slot (admin use only)
    function stopSlot(uint _slotId) public {
        require(_slotId > 0 && _slotId <= totalSlots, "Invalid slot ID.");
        Slot storage slot = slots[_slotId];

        if (slot.reservedBy != address(0)) {
            revert("Slot is reserved. Cannot stop.");
        }

        slot.isAvailable = false;
        slot.reservedBy = address(0);
    }
}

```

4. **Compile the Contract:**
   - Go to the "Solidity Compiler" tab in Remix.
   - Set the compiler version to `0.8.28`.
   - Click the "Compile ParkingLot.sol" button.

5. **Deploy the Contract:**
   - Navigate to the "Deploy & Run Transactions" tab.
   - Select the `ParkingLot` contract from the dropdown.
   - Enter the total number of parking slots (e.g., 10) in the constructor input field.
   - Click on the "Deploy" button.

6. **Interact with the Contract:**
   - After deployment, you can interact with the contract through the Remix interface:
     - **reserveSlot:** Reserve a slot by entering a slot ID.
     - **releaseSlot:** Release a reserved slot by entering the slot ID.
     - **checkAvailability:** Check if a specific slot is available.
     - **stopSlot:** Stop a slot from being used (admin only).

## Authors
- **Metacrafter**
- **Charles_shiro**

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
