// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract ABI {
    function encode(
        uint256 _int,
        string calldata _string,
        address _address
    ) external pure returns (bytes memory) {
        return abi.encode(_int, _string, _address);
    }

    function decode(bytes calldata _bytes)
        external
        pure
        returns (
            uint256 _int,
            string memory _string,
            address _address
        )
    {
        (_int, _string, _address) = abi.decode(
            _bytes,
            (uint256, string, address)
        );
    }
}
