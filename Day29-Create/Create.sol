//SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/utils/Create2.sol";
import "./Name.sol";

contract Create {
    function deployContract(bytes32 _salt, string calldata name) external returns (bool) {
        Create2.deploy(
            0,
            _salt,
            abi.encodePacked(type(Name).creationCode, abi.encode(name))
        );

        return true;
    }

    function computeContractAddress(bytes32 _salt, string calldata name)
        public
        view
        returns (address)
    {
        return
            Create2.computeAddress(
                _salt,
                keccak256(
                    abi.encodePacked(
                        type(Name).creationCode,
                        abi.encode(name)
                    )
                )
            );
    }
}
