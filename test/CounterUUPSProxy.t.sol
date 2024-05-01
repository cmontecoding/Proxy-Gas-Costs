// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {CounterUUPSProxy} from "../src/CounterUUPSProxy.sol";
import {CounterUUPSProxyV2} from "../src/CounterUUPSProxyV2.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract CounterUUPSProxyTest is Test {
    CounterUUPSProxy public uupsImplementation;
    CounterUUPSProxy public uupsProxy;

    function setUp() public {
        uupsImplementation = new CounterUUPSProxy();

        ERC1967Proxy proxy = new ERC1967Proxy(address(uupsImplementation), "");
        uupsProxy = CounterUUPSProxy(address(proxy));
    }

    function test_Increment() public {
        uupsProxy.increment();
        assertEq(uupsProxy.number(), 1);
    }

    function testUpgrade() public {
        CounterUUPSProxyV2 uupsImplementationV2 = new CounterUUPSProxyV2();
        uupsProxy.upgrade(address(uupsImplementationV2));
    }
}
