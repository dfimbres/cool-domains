// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.10;

import "hardhat/console.sol";
import { StringUtils } from "./libraries/StringUtils.sol";

contract Domains {
     string public tld;
    // A "mapping" data type to store their names
    mapping(string => address) public domains;

    // Checkout our new mapping! This will store values
    mapping(string => string) public records;

    constructor(string memory _tld) {
        tld = _tld;
        console.log("%s name service deployed", _tld);
    }

    function price(string calldata name) public pure returns(uint) {
        uint len = StringUtils.strlen(name);
        require(len > 0);

        if(len == 3) {
            return 5 * 10**17; //.5 MATIC
        } else if (len == 4) {
            return 4 * 10**17;
        } else {
            return 1 * 10**17;
        }
    }

    function register(string calldata name) public payable{
        require(domains[name] == address(0));

        uint _price = price(name);

        // Check if enough Matic was paid in the transaction
        require(msg.value >= _price, "Not enough Matic paid");

        domains[name] = msg.sender;
        console.log("%s has registered a domain!", msg.sender);
    }

    // This will give us the domain owners' address
    function getAddress(string calldata name) public view returns (address) {
        return domains[name];
    }

    function setRecord(string calldata name, string calldata record) public {
        require(domains[name] == msg.sender, "This is not the domain owner");
        records[name] = record;
    }

    function getRecord(string calldata name) public view returns (string memory) {
        return records[name];
    }
}