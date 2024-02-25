// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/utils/Arrays.sol";

contract Parent {
    uint256[] public arr = [0, 1, 2, 3, 5, 7, 9];

    function findUpperBound(uint256 element) public view returns (uint256) {
        return Arrays.findUpperBound(arr, element);
    }

    function unsafeAccess(uint256 element) public view returns(StorageSlot.Uint256Slot memory) {
        return Arrays.unsafeAccess(arr,  element);
    }

    function unsafeMemoryAccess(uint256 element) public view returns(uint256) {
        return Arrays.unsafeMemoryAccess(arr, element);
    }
}
