// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Deed {
  address public lawyer;
  address payable public beneficiary;
  uint public earliest;

  constructor(
    address _lawyer, 
    address payable _beneficiary, 
    uint fromNow) 
    payable 
    public {
    lawyer = _lawyer;
    beneficiary = _beneficiary; 
    earliest = block.timestamp + fromNow;
  }

  function withdraw() public {
    require(msg.sender == lawyer, 'lawyer only');
    require(block.timestamp >= earliest, 'too early');
    beneficiary.transfer(address(this).balance);
  }
}



contract DeedMultiPayout {
  address public lawyer;
  address payable public beneficiary;
  uint public earliest;
  uint public amount;
  uint constant public PAYOUTS = 10;
  uint constant public INTERVAL = 10;
  uint public paidPayouts;
  
  constructor(
    address _lawyer,
    address payable _beneficiary,
    uint fromNow)
    payable
    public {
        lawyer = _lawyer;
        beneficiary = _beneficiary;
        earliest = block.timestamp + fromNow;
        amount = msg.value / PAYOUTS;
    }
  
  function withdraw() public {
    require(msg.sender == beneficiary, 'beneficiary only');
    require(block.timestamp >= earliest, 'too early');
    require(paidPayouts < PAYOUTS, 'no payout left');
    
    uint elligiblePayouts = (block.timestamp - earliest) / INTERVAL;
    uint duePayouts = elligiblePayouts - paidPayouts;
    duePayouts = duePayouts + paidPayouts > PAYOUTS ? PAYOUTS - paidPayouts : duePayouts;
    paidPayouts += duePayouts;
    beneficiary.transfer(duePayouts * amount);
  }
}