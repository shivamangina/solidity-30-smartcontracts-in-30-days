// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract EtherWallet {
    address public owner;

    constructor() {
        owner = msg.sender;
    }


    function withdraw(uint256 amount) external {
        require(owner==msg.sender,"Only owner can with draw funds");
        payable(owner).transfer(amount);

    }


    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable { }
}
