// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract CurrencyConverter is Ownable{
    // This struct will hold the address of the Chainlink Currency Converter and a description.
    struct FeedInfo {
        AggregatorV3Interface aggregator;
        string description;
    }

    // Mapping from an integer identifier to a FeedInfo.
    mapping(uint => FeedInfo) public feeds;

    // Mapping from feed ID to the last fetched price.
    mapping(uint => int) public lastFetchedPrice;

    // Event for updating feed address.
    event FeedAddressUpdated(uint feedId, address newAddress, string description);

    // Event that logs the price request details.
    event PriceRequested(string description, int price);

    constructor() Ownable(msg.sender) {
        // Initialize with the Chainlink data feed addresses.
        feeds[1] = FeedInfo(AggregatorV3Interface(0x5fb1616F78dA7aFC9FF79e0371741a747D2a7F22), "BTC/ETH");
        feeds[2] = FeedInfo(AggregatorV3Interface(0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43), "BTC/USD");
        feeds[3] = FeedInfo(AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306), "ETH/USD");
        feeds[4] = FeedInfo(AggregatorV3Interface(0xc59E3633BAAC79493d908e63626716e204A45EdF), "LINK/USD");
    }

    /**
     * Fetches the latest price from the specified Chainlink Data Feed and updates the stored price.
     * @param feedId the integer identifier of the feed
     */
    function updatePrice(uint feedId) public {
        FeedInfo storage feed = feeds[feedId];
        require(address(feed.aggregator) != address(0), "Feed not found");

        (
        /* uint80 roundID */,
            int price,
        /* uint startedAt */,
        /* uint timeStamp */,
        /* uint80 answeredInRound */
        ) = feed.aggregator.latestRoundData();

        // Update the stored price for the feed.
        lastFetchedPrice[feedId] = price;

        // Emit an event with the price and the description.
        emit PriceRequested(feed.description, price);
    }

    /**
     * Returns the last fetched price for the specified feed.
     * @param feedId the integer identifier of the feed
     */
    function getLastFetchedPrice(uint feedId) public view returns (int) {
        require(lastFetchedPrice[feedId] != 0, "Price not fetched yet");
        return lastFetchedPrice[feedId];
    }

    /**
     * Updates the address of a Chainlink Data Feed for a specific feed ID. Only the owner can call this function.
     * @param feedId the integer identifier of the feed
     * @param newAddress the new address of the Chainlink Data Feed
     */
    function updateFeedAddress(uint feedId, address newAddress) public onlyOwner {
        require(newAddress != address(0), "New address cannot be the zero address.");
        require(feedId > 0 && feedId <= 4, "Feed ID out of range."); // Assuming you only have 4 feeds.
        feeds[feedId].aggregator = AggregatorV3Interface(newAddress);

        // Emit an event that the feed address was updated.
        emit FeedAddressUpdated(feedId, newAddress, feeds[feedId].description);
    }
}