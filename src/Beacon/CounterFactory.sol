// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BeaconProxy} from "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";

contract CounterFactory {

    address public immutable beacon;

    constructor(address Beacon) {
        beacon = Beacon;
    }

    function createBeaconProxy() external returns (address) {
        BeaconProxy proxy = new BeaconProxy(beacon, "");
        return address(proxy);
    }
}