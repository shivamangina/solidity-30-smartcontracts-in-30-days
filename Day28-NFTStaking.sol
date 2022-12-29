// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract RewardsToken is ERC20 {
    constructor(string memory _name, string memory _symbol)
        ERC20(_name, _symbol)
    {
        _mint(msg.sender, 1000000 * 10**decimals());
    }

    function mint(uint256 quantity) external payable {
        // _safeMint's second argument now takes in a quantity, not a tokenId.
        require(quantity > 0, "Quantity cannot be zero");
        uint256 totalMinted = totalSupply();
        require(quantity <= MAX_MINTS, "Cannot mint that many at once");
        require(
            totalMinted.add(quantity) < MAX_SUPPLY,
            "Not enough tokens left to mint"
        );
        require(msg.value >= (mintRate * quantity), "Insufficient funds sent");
        _safeMint(msg.sender, quantity);
    }
}
