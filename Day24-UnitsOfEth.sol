// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract UnitsOfEth {
    constructor() payable {}

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function getBalanceEth() public view returns (uint256) {
        return address(this).balance / 1 ether;
    }

    function getBalanceEth2() public view returns (uint256) {
        return address(this).balance / 1e18;
    }

    function getBalanceGwei() public view returns (uint256) {
        return address(this).balance / 1 gwei; // 1e9
    }
}
