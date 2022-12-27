// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

/**
Ether Wallet -
any one can send ether to this contract
and the ether will be stored in this contract
only the owner of this contract can withdraw the ether
the owner of this contract is the address that deployed this contract
 */

contract EtherWallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function withdraw(uint256 _amount) external {
        require(msg.sender == owner, "only the owner can call this function");
        owner.transfer(_amount);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {}
}
