// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import { Script } from "forge-std/Script.sol";
import { EnteralKingdomNFTFactory2 } from "src/EnteralKingdomNFTFactory.sol";

contract DeployEtherWallet is Script{

    function run() external returns (EnteralKingdomNFTFactory2 factory) {
    
        // uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        // vm.startBroadcast(deployerPrivateKey);
        vm.startBroadcast();
        factory = new EnteralKingdomNFTFactory2();

        vm.stopBroadcast();
    }

}