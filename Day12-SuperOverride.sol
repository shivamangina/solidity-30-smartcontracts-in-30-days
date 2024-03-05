// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Parent {
    uint256 public u;

    function setToOne() public {
        u = 1;
    }

    function increment() public virtual {
        u = u+1;
    }
}

contract Child is Parent {
    function updatesSetToOne() external returns (uint256) {
        super.setToOne();
        return u;
    }

    function increment() public override {
        u = u+2;
    }
}
