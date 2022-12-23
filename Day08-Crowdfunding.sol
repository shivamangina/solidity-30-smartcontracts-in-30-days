// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./Owner.sol";

/**
 * @title CreateFund
 * @dev Implements creater fund donation
 */
contract CreatorFund is Owner {
  struct Creator {
    string[] tags;
    string photo; // personal info
    string description;
    string emailId;
    string website;
    string linkedIn; // social media
    string instagram;
    string twitter;
    string country;
  }

  struct User {
    address payable walletAddress;
    string name;
    bool isDisabled; // disable user
    bool isCreator;
    uint256 totalFundContributorsCount;
    uint256 totalFundsReceived;
    uint256 totalCreatorsFundedCount;
    uint256 totalFundsSent;
    uint256 withdrawbleBalance;
  }

  address[] public totalCreatorsList;
  address[] totalUsersList;

  mapping(address => mapping(address => uint256)) public sentFundsList; // funds sent from wallet
  mapping(address => mapping(address => uint256)) public receivedFundsList; // funds received in wallet
  mapping(address => User) public users;
  mapping(address => Creator) public creators;

  function getContractBalance() public view returns (uint256) {
    return address(this).balance;
  }

  function createUser(string memory _name) public returns (bool) {
    address payable wallet = payable(msg.sender);
    users[msg.sender] = User(wallet, _name, false, false, 0, 0, 0, 0, 0);
    totalUsersList.push(msg.sender);
    return true;
  }

  function createOrUpdateCreator(
    string[] memory _tags,
    string memory _photo,
    string memory _description,
    string memory _emailId,
    string memory _website,
    string memory _linkedIn,
    string memory _instagram,
    string memory _twitter,
    string memory _country
  ) public returns (bool) {
    User storage myUser = users[msg.sender];

    if (myUser.isCreator == false) {
      totalCreatorsList.push(msg.sender);
    }

    myUser.isCreator = true;
    creators[msg.sender] = Creator(_tags, _photo, _description, _emailId, _website, _linkedIn, _instagram, _twitter, _country);

    return true;
  }

  function donate(address payable _creator, uint256 _price) public payable returns (bool) {
    // require(msg.value >=minimumContribution,"Minimum Contribution is not met");
    // require(msg.value == _price,"Minimum Contribution is not met");
    require(users[_creator].isCreator == true, "User is not a Creator");
    require(users[_creator].isDisabled == false, "User is Disabled");
    require(_price > 0, "Donations cannot be below 0");
    if (sentFundsList[msg.sender][_creator] == 0) {
      users[msg.sender].totalCreatorsFundedCount++;
    }
    users[msg.sender].totalFundsSent += _price;
    sentFundsList[msg.sender][_creator] += _price;
    if (receivedFundsList[_creator][msg.sender] == 0) {
      users[_creator].totalFundContributorsCount++;
    }
    users[_creator].totalFundsReceived += _price;
    receivedFundsList[_creator][msg.sender] += _price;
    users[_creator].withdrawbleBalance += _price;
    return true;
  }

  function withdraw(uint256 _withdrawAmount) public {
    uint256 actualWithdrawAmount = _withdrawAmount * 10**18;
    require(users[msg.sender].withdrawbleBalance > actualWithdrawAmount, "requested amount is higher than the available then the withdrawAmount");
    User storage thisUser = users[msg.sender];
    thisUser.walletAddress.transfer(actualWithdrawAmount);
    thisUser.withdrawbleBalance -= actualWithdrawAmount;
  }

  function getCreatorInfo(address _address)
    public
    view
    returns (
      string[] memory,
      string memory,
      string memory,
      string memory,
      string memory,
      string memory,
      string memory,
      string memory,
      string memory
    )
  {
    require(users[_address].walletAddress != address(0), "No User Found");
    require(users[_address].isCreator == true, "User is not a Creator");
    Creator memory myCreator = creators[_address];
    return (
      myCreator.tags,
      myCreator.photo,
      myCreator.description,
      myCreator.emailId,
      myCreator.website,
      myCreator.linkedIn,
      myCreator.instagram,
      myCreator.twitter,
      myCreator.country
    );
  }

  function getUserData(address _address)
    public
    view
    returns (
      address,
      string memory,
      bool,
      bool,
      uint256,
      uint256,
      uint256,
      uint256,
      uint256
    )
  {
    require(users[_address].walletAddress != address(0), "No User Found");
    User memory myUser = users[_address];
    return (
      myUser.walletAddress,
      myUser.name,
      myUser.isDisabled,
      myUser.isCreator,
      myUser.totalFundContributorsCount,
      myUser.totalFundsReceived,
      myUser.totalCreatorsFundedCount,
      myUser.totalFundsSent,
      myUser.withdrawbleBalance
    );
  }

  function disableUser(address _creator) public isOwner returns (bool) {
    users[_creator].isDisabled = true;
    return true;
  }

  function getAllCreatorsList() public view returns (address[] memory) {
    return totalCreatorsList;
  }
}