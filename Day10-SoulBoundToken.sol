// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "github.com/omaraflak/ERC4671/contracts/ERC4671.sol";

contract UniversityCertificates is ERC4671 {
    constructor() ERC4671("University Certificate Token", "UCT") {}

    function mintCertificate(address student) external {
        require(_isCreator(), "You must be creator of the contract");
        _mint(student);
    }
}
