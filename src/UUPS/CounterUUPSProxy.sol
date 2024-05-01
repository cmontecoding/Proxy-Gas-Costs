// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract CounterUUPSProxy is UUPSUpgradeable {
    uint256 public number;

    function initialize() public {
        number = 1;
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }

    function upgrade(address _newImplementation) public {
        upgradeToAndCall(_newImplementation, "");
    }

    function _authorizeUpgrade(address newImplementation) internal override {}
}
