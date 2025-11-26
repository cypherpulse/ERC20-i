// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "lib/forge-std/src/Script.sol";
import {BasedBradley} from "../src/BasedBradley.sol";

contract BasedBradleyToken is Script {
    uint256 public constant INITIAL_SUPPLY = 1000 ether;

    function run() external returns (BasedBradley) {
        vm.startBroadcast();
        BasedBradley bb = new BasedBradley(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return bb;
    }
}
