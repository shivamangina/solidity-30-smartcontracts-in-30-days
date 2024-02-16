
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract DataConsumerV3 {
    AggregatorV3Interface internal dataFeed;

    constructor() {
        dataFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
    }

    function getChainlinkDataFeedLatestAnswer() public  view returns (int256) {
        (, int256 answer, , , ) = dataFeed.latestRoundData();
        return answer;
    }

    function getBalanceInUSD() public view returns (uint256) {
        uint256 bal = address(this).balance;
        int256 usd = getChainlinkDataFeedLatestAnswer();
        return uint256(usd) * bal;
    }

    receive() external payable {}
}
