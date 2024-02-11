// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Factory {
    Child[] public children;

    event ChildCreated(address childAddress, uint256 id);

    function createChild(uint256 _id) external {
        Child child = new Child(_id);
        children.push(child);

        emit ChildCreated(address(child), _id);
    }
}

contract Child {
    uint256 id;

    constructor(uint256 _id) {
        id = _id;
    }
}
