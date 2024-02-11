// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MultisigWallet {
    address[] public owners;
    uint256 public minNumOfConfirmations;

    struct Transaction {
        address to;
        uint256 value;
        bytes data;
        bool executed;
        uint256 numOfConfirmations;
    }

    Transaction[] public transactions;
    mapping(uint256 => mapping(address => bool)) public isConfirmed;
    mapping(address => bool) public isOwner;


    modifier onlyOwner(){
        require(isOwner[msg.sender],"Not Owner");
        _;
    }

    constructor(address[] memory _owners, uint256 _minNumOfConfirmations) {
        require(_owners.length > 0, "Owners should be at least 1");
        require(
            _owners.length >= _minNumOfConfirmations,
            "Numbe of owners should match _minNumOfConfirmations"
        );

        for (uint256 i = 0; i < _owners.length; i++) {
            owners.push(_owners[i]);
            isOwner[_owners[i]] = true;
        }

        minNumOfConfirmations = _minNumOfConfirmations;
    }

    function submitTransaction(
        address _to,
        uint256 _value,
        bytes memory _data
    ) public {
        transactions.push(
            Transaction({
                to: _to,
                value: _value,
                data: _data,
                executed: false,
                numOfConfirmations: 0
            })
        );
    }

    function confirmTransaction(uint256 _txIndex) public {
        require(
            !transactions[_txIndex].executed,
            "Transaction Already Executed"
        );
        require(
            !isConfirmed[_txIndex][msg.sender],
            " Transaction is already confirmed"
        );

        Transaction storage transaction = transactions[_txIndex];
        transaction.numOfConfirmations += 1;

        isConfirmed[_txIndex][msg.sender] = true;
    }

    function executeTransaction(uint256 _txIndex) public {
        Transaction storage transaction = transactions[_txIndex];
        require(
            transaction.numOfConfirmations >= minNumOfConfirmations,
            "Transaction not confirmed"
        );

        transaction.executed = true;
        (bool success, ) = transaction.to.call{value: transaction.value}(
            transaction.data
        );

        require(success, "Transaction Not succeded on chain");
    }

    receive() external payable {}
}
