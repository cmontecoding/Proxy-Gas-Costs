// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BeaconProxy} from "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";
import {UpgradeableBeacon} from "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";

contract CounterFactoryBeacon is UpgradeableBeacon {

    constructor(address _implementation, address authorized) UpgradeableBeacon(_implementation, authorized) {}

    function createBeaconProxy() external returns (address) {
        BeaconProxy proxy = new BeaconProxy(address(this), "");
        return address(proxy);
    }
}