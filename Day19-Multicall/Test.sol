// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Test {
    string public name;
    uint256 public age;

    constructor() {}

    function setName(string calldata _name) public {
        name = _name;
    }

    function setAge(uint256 _age) public {
        age = _age;
    }
}
