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
