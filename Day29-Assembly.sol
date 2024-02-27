// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Assembly {
    function yul_let() public pure returns (uint256 z) {
        assembly {
            // Language used for assembly is called Yul
            // Local variables
            let x := 1

            if lt(x, 10) {
                z := 99
            }
        }
    }
}
