// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/**
 * require statement
 * math operations
 * functions
 */
contract Calulator {
    int256 result;

    function add(int256 a, int256 b) public {
        result = a + b;
    }

    function sub(int256 a, int256 b) public {
        result = a - b;
    }

    function mul(int256 a, int256 b) public {
        result = a * b;
    }

    function div(int256 a, int256 b) public {
        require(b > 0, "The second parameter should be larger than 0");
        result = a / b;
    }

    function getResult() public view returns (int256) {
        return result;
    }
}
