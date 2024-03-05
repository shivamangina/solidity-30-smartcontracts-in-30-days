// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Multicall {
    error CallFailed();

    function multicall(address[] calldata _targets, bytes[] calldata _data)
        public
    {
        for (uint256 i; i < _targets.length; i++) {
            (bool success, ) = _targets[i].call(_data[i]);
            if (!success) {
                revert CallFailed();
            }
        }
    }
}
