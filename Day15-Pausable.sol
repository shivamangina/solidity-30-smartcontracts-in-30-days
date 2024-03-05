// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/utils/Pausable.sol";

contract Parent is Pausable {
    uint256 public number;

    function setToOne() public whenNotPaused() {
        number = 1;
    }

    function increment() public whenNotPaused() {
        number = number + 1;
    }

    function pause() external {
        _pause();
    }

    function unpause() external {
        _unpause();
    }
}
