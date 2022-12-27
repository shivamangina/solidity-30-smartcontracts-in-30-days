// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/**
-- Auction --
auctioneer - can start auction, can cancel auction, 
users - can make a bid
 */

contract Auction {
    address payable public beneficiaryAddress;
    uint256 public highestBid;
    address public highestBidder;
    uint256 public endTime;

    bool public auctionComplete;

    event auctionResult(address winner, uint256 bidAmount);
    event topBidIncreased(address bidder, uint256 bidAmount);

    mapping(address => uint256) returnsPending;

    function startAuction(uint256 _endTime, address _beneficiaryAddress)
        public
    {
        beneficiaryAddress = payable(_beneficiaryAddress);
        endTime = _endTime;
    }

    function endAuction() public {
        require(msg.sender == beneficiaryAddress);
        // only beneficiaryAddress can cancel

        require(block.timestamp >= endTime); // auction did not yet end
        require(!auctionComplete); // this function has already been called

        auctionComplete = true;

        emit auctionResult(highestBidder, highestBid);

        beneficiaryAddress.transfer(highestBid);
        returnsPending[highestBidder] = 0;
    }

    function cancelAuction() public {
        require(msg.sender == beneficiaryAddress);
        // only beneficiaryAddress can cancel
        auctionComplete = true;
    }

    function bid() public payable {
        // No argument is necessary, all
        // information is already added to
        // the transaction. The keyword payable
        // is required so the function
        // receives Ether.

        // Revert the call in case the bidding
        // period is over.
        require(block.timestamp >= endTime); // auction did not yet end

        // If the bid is not greater,
        // the money is sent back.
        require(msg.value > highestBid);

        highestBidder = msg.sender;
        highestBid = msg.value;
        emit topBidIncreased(msg.sender, msg.value);
    }

    function withdraw() public returns (bool) {
        require(msg.sender == beneficiaryAddress);
        uint256 bidAmount = returnsPending[msg.sender];
        if (bidAmount > 0) {
            // It is important to set this to zero because the recipient
            // can call this function again as part of the receiving call
            // before `send` returns.
            returnsPending[msg.sender] = 0;

            if (!payable(msg.sender).send(bidAmount)) {
                // Calling throw not necessary here, simply reset the bidAmount owing
                returnsPending[msg.sender] = bidAmount;
                return false;
            }
        }
        return true;
    }
}
