// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Gasleft {
    uint256 public value;
    uint public intialGas;
    uint public finalGas;

    constructor() {}

    function setValue(uint256 _value) public returns (uint) {
        intialGas = gasleft();
        value = _value;
        finalGas = gasleft();
        return intialGas - finalGas;
    }
}
