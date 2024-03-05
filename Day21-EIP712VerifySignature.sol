// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";

contract Greeter is EIP712 {
    string public greetingText = "Hello World!";
    address public owner;

    struct Greeting {
        string text;
    }

    constructor() EIP712("Ether Mail", "1") {
        owner = msg.sender;
    }

    function verify(Greeting memory greeting, bytes memory signature)
        internal
        view
        returns (bool)
    {
        bytes32 digest = _hashTypedDataV4(
            keccak256(
                abi.encode(
                    keccak256("Greeting(string text)"),
                    keccak256(bytes(greeting.text))
                )
            )
        );
        address signer = ECDSA.recover(digest, signature);

        return signer == owner;
    }

    function greet(Greeting memory greeting, bytes memory signature) public {
        require(verify(greeting, signature), "Invalid signature");

        greetingText = greeting.text;
    }
}
