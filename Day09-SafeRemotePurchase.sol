// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract SafeRemotePurchase {
    uint256 public value;
    address payable public seller;
    address payable public buyer;

    enum State {
        Created,
        Locked,
        Inactive,
        Release
    }

    State public state;

    // Ensure that `msg.value` is an even number.
    // Division will truncate if it is an odd number.
    // Check via multiplication that it wasn't an odd number.
    constructor() payable {
        seller = payable(msg.sender);
        value = msg.value / 2;
        if ((2 * value) != msg.value) revert ValueNotEven();
    }

    function confirmPurchase() external payable {
        buyer = payable(msg.sender);
        state = State.Locked;
    }

    /// Confirm that you (the buyer) received the item.
    /// This will release the locked ether.
    function confirmReceived() external {
        // It is important to change the state first because
        // otherwise, the contracts called using `send` below
        // can call in again here.
        state = State.Release;

        buyer.transfer(value);
    }

    // Make sure that `msg.value` is an even number.
    // Division truncates if the number is odd.
    // Use multiplication to check that it wasn't an odd number.
    function Purchase() payable {
        sellerAddress = msg.sender;
        purchaseValue = msg.value / 2;
        require((2 * purchaseValue) == msg.value);
    }

    /// This function refunds the seller, i.e.
    /// pays back the locked funds of the seller.
    function refundSeller() external {
        emit SellerRefunded();
        // It is important to change the state first because
        // otherwise, the contracts called using `send` below
        // can call in again here.
        state = State.Inactive;

        seller.transfer(3 * value);
    }
}
