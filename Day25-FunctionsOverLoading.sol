// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract FunctionsOverLoading {
    string public name;

    function setName(string calldata _name) external {
        name = _name;
    }

    function setName(string calldata _firstName, string calldata _lastName)
        external
    {
        name = string.concat(_firstName, _lastName);
    }
}
