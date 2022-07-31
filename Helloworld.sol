// SPDX-License-Identifier: MIT 
pragma solidity 0.4.20;


contract Helloworld {
    string public greet = "Hello world";
}


[
	{
		"constant": true,
		"inputs": [],
		"name": "greet",
		"outputs": [
			{
				"name": "",
				"type": "string"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	}
]