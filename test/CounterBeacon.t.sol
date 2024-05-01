// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Beacon/CounterImplementation.sol";
import {CounterV2} from "../src/Beacon/CounterImplementationV2.sol";
import {CounterFactory} from "../src/Beacon/CounterFactory.sol";
import {CounterFactoryBeacon} from "../src/Beacon/CounterFactoryBeacon.sol";
import {UpgradeableBeacon} from "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";

contract BeaconTest is Test {
    Counter public implementation;
    CounterFactory public factory;
    Counter public proxy;
    UpgradeableBeacon public beacon;
    CounterFactoryBeacon public factoryBeacon;

    function setUp() public {
        implementation = new Counter();
        beacon = new UpgradeableBeacon(address(implementation), address(this));

        factory = new CounterFactory(address(beacon));
        proxy = Counter(factory.createBeaconProxy());

        factoryBeacon = new CounterFactoryBeacon(address(implementation), address(this));
    }

    function test_Increment() public {
        proxy.increment();
        assertEq(proxy.number(), 1);
    }

    function testUpgrade() public {
        CounterV2 implementationV2 = new CounterV2();
        beacon.upgradeTo(address(implementationV2));
    }

    function testDeployBeacon() public {
        UpgradeableBeacon newBeacon = new UpgradeableBeacon(address(implementation), address(this));
    }

    function testDeployFactory() public {
        CounterFactory newFactory = new CounterFactory(address(beacon));
    }

    function testDeployNewProxy() public {
        Counter newProxy = Counter(factory.createBeaconProxy());
    }

    function testDeployFactoryBeacon() public {
        CounterFactoryBeacon newFactoryBeacon = new CounterFactoryBeacon(address(implementation), address(this));
    }

    function testDeployNewProxyWithFactoryBeacon() public {
        Counter newProxy = Counter(factoryBeacon.createBeaconProxy());
    }

    function testDeployImplementation() public {
        Counter newImplementation = new Counter();
    }
}
