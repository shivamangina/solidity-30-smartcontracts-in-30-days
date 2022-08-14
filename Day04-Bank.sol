// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.13;

contract Bank {

    struct Account {
        uint balance;
        bool isActive;
        bool isExists;
    } 

    mapping(address=>Account) public userAccounts;

    function createAccount() public payable returns (bool){
        require(userAccounts[msg.sender].isExists==false,"Account already created");
        Account memory newAccount = Account(msg.value,true,true );
        userAccounts[msg.sender] = newAccount;
        return true;
    }

      function deposit() public payable returns (bool){
        require(userAccounts[msg.sender].isExists==true, 'Account is not created');
        require(msg.value>0, 'Value for deposit is Zero');
        userAccounts[msg.sender].balance = userAccounts[msg.sender].balance+msg.value;
        return true;
    }

    function withdraw(uint _amount)public returns (bool){
      
      require(userAccounts[msg.sender].isExists==true, 'Account is not created');
      require(userAccounts[msg.sender].balance>_amount, 'insufficent balance in Bank account');
      require(_amount>0, 'Enter non-zero value for withdrawal');

      userAccounts[msg.sender].balance = userAccounts[msg.sender].balance - _amount;
      payable(msg.sender).transfer(_amount);
      return true;
        
    }
      function transfer(uint _amount , address _toAddress) public returns (bool){
        require(userAccounts[msg.sender].isExists==true, 'Account is not created');
        require(userAccounts[_toAddress].isExists==true, 'To Account is not created');

      require(userAccounts[msg.sender].balance>_amount, 'insufficent balance in Bank account');

       userAccounts[msg.sender].balance = userAccounts[msg.sender].balance - _amount;
       userAccounts[_toAddress].balance = userAccounts[msg.sender].balance + _amount;

       return true;
        
    }


      function sendToWallet(uint _amount , address payable _toAddress) public returns (bool){

      require(userAccounts[msg.sender].isExists==true, 'Account is not created');
      require(userAccounts[msg.sender].balance>_amount, 'insufficent balance in Bank account');
      require(_amount>0, 'Enter non-zero value for withdrawal');

      userAccounts[msg.sender].balance = userAccounts[msg.sender].balance - _amount;
      _toAddress.transfer(_amount);
      return true;
        
    }

    function getBalance() public view returns (uint){
        return userAccounts[msg.sender].balance;
    }


}