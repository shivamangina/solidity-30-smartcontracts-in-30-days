// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/Address.sol";

contract BatchTransfer {
    function batchTransferEth(
        address payable[] calldata _addresses,
        uint256[] calldata values
    ) public {
        for (uint256 i = 0; i < _addresses.length; i++) {
            Address.sendValue(_addresses[i], values[i]);
        }
    }

    receive() external payable { }
}

