// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract AssemblyLoop {
    function yul() public pure returns (uint256 z) {
        assembly {

            for { let i:= 0 } lt(i,10) { i:= add(i,1) }{
                z:= add(z,1)
            }

        }
    }
}
