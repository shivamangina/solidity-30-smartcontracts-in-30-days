// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/utils/Strings.sol";

contract Parent {
  

    function toString(uint256 _number) public pure returns (string memory) {
        return Strings.toString(_number);
    }

    function toStringSigned(int256 _number)
        public
        pure
        returns (string memory)
    {
        return Strings.toStringSigned(_number);
    }

    function toHexString(uint256 _number) public pure returns (string memory) {
        return Strings.toHexString(_number);
    }

    function toHexString(uint256 _number, uint256 length)
        public
        pure
        returns (string memory)
    {
        return Strings.toHexString(_number, length);
    }

    function toHexString(address _addr) public pure returns (string memory) {
        return Strings.toHexString(_addr);
    }

    function equal(string calldata _a, string calldata _b)
        public
        pure
        returns (bool)
    {
        return Strings.equal(_a, _b);
    }
}
