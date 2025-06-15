// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import { Test } from "forge-std/Test.sol";
import { IPILicenseTemplate } from "@storyprotocol/core/interfaces/modules/licensing/IPILicenseTemplate.sol";
import { PILTerms } from "@storyprotocol/core/interfaces/modules/licensing/IPILicenseTemplate.sol";

// Run this test:
// forge test --fork-url https://aeneid.storyrpc.io/ --match-path test/1_LicenseTerms.t.sol
contract LicenseTermsTest is Test {
    address internal tusharpamnani = address(0xa11ce);

    // For addresses, see https://docs.story.foundation/developers/deployed-smart-contracts
    // Protocol Core - PILicenseTemplate
    IPILicenseTemplate internal PIL_TEMPLATE = IPILicenseTemplate(0x2E896b0b2Fdb7457499B56AAaA4AE55BCB4Cd316); //  the contract where new license terms are registered.
    // Protocol Core - RoyaltyPolicyLAP
    address internal ROYALTY_POLICY_LAP = 0xBe54FB168b3c982b7AaE60dB6CF75Bd8447b390E; // defines how royalties are distributed.
    // Revenue Token - MERC20
    address internal MERC20 = 0xF2104833d386a2734a4eB3B8ad6FC6812F29E38E; // the token used to pay royalties.

    function setUp() public {}

    /// @notice Registers new PIL Terms. Anyone can register PIL Terms.
    function test_registerPILTerms() public {
        PILTerms memory pilTerms = PILTerms({
            transferable: true, // true means the NFT can be transferred.
            royaltyPolicy: ROYALTY_POLICY_LAP, // address of royalty logic.
            defaultMintingFee: 0, // 0 means no minting fee is required.
            expiration: 0, // 0 means no expiration.
            commercialUse: true, // true means the NFT can be used commercially.
            commercialAttribution: true, 
            commercializerChecker: address(0), // address(0) means no commercializer checker is used.
            commercializerCheckerData: "",
            commercialRevShare: 0, 
            commercialRevCeiling: 0,
            derivativesAllowed: true, // derivative works are allowed.
            derivativesAttribution: true, 
            derivativesApproval: true,
            derivativesReciprocal: true, 
            derivativeRevCeiling: 0, // 0 means no derivative rev ceiling is required.
            currency: MERC20, // the token used to pay royalties.
            uri: "" // the URI of the license terms.
        });
        uint256 licenseTermsId = PIL_TEMPLATE.registerLicenseTerms(pilTerms);

        // Get the license terms ID and verify it matches the registered one.
        uint256 selectedLicenseTermsId = PIL_TEMPLATE.getLicenseTermsId(pilTerms);
        assertEq(licenseTermsId, selectedLicenseTermsId);
    }
}