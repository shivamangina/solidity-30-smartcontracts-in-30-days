// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract GlobalVariables {
    uint256 public basefee;
    uint256 public chainId;
    uint256 public blockNumber;
    uint256 public gaslimit;
    address public minerAddress;
    uint256 public timestamp;
    bytes32 public blockHash;

    constructor() {
        basefee = block.basefee;
        chainId = block.chainid;
        blockNumber = block.number;
        gaslimit = block.gaslimit;
        minerAddress = block.coinbase;
        timestamp = block.timestamp;
        blockHash = blockhash(block.number - 1);
    }
}
