//SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Name {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

