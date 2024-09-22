// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;
import {Test, console2} from "forge-std/Test.sol";
import {EnteralKingDomERC721} from '../src/EnteralKingDomERC721.sol';
import {EnteralKingdomNFTFactory2} from   '../src/EnteralKingdomNFTFactory.sol';


contract EnteralKingDomERC21Test is Test {

    EnteralKingDomERC721  private  erc721;
    EnteralKingdomNFTFactory2 private factory;

    address private constant owner = address(1);
    address private constant alice = address(11);
    address private constant bob = address(12);
    address private constant carol = address(13);
    address private constant eve = address(14);

    event Transfer(
        address indexed src, address indexed dst, uint256 indexed id
    );
    event Approval(
        address indexed owner, address indexed spender, uint256 indexed id
    );
    event ApprovalForAll(
        address indexed owner, address indexed operator, bool approved
    );

    function setUp() public {
    
        vm.prank(owner);
        factory = new EnteralKingdomNFTFactory2();
        vm.label(address(factory), "EnteralKingdomNFTFactory2");

        uint256 salt = 1;
        address n = factory.deploy(owner, salt, "EnteralKingdomNFT1", "EKL");
        erc721 = EnteralKingDomERC721(n);
        vm.label(address(erc721), "EnteralKingdomNFT1");

    }

    // function test_deploy() public   {
    //     uint256 salt = 2;
    //     address add = factory.deploy(owner, salt, "EnteralKingdomNFT1", "EKL");
    //     erc721 = EnteralKingDomERC21(add);
    //     assertEq(erc721.name(), "EnteralKingdomNFT1");
    //     assertEq(erc721.symbol(), "EKL");
    //     address add2 = factory.getContractAddress(owner,"EnteralKingdomNFT1", "EKL", salt);
    //     assertEq(factory.nfts(salt), add);
    //     assertEq(add, add2);
    // }

    
    // function test_ownerOf_non_existing_id() public {
    //     vm.expectRevert();
    //     erc721.ownerOf(0);
    // }

    // function test_balanceOf() public {
    //     vm.expectRevert();
    //     erc721.balanceOf(address(0));
    //     assertEq(erc721.balanceOf(address(1)), 0);
    // }

    // function test_mintNFT() public {
    //     // Revert mint if id is already minted
   
    //     vm.prank(owner);
    //     erc721.mintNFT(alice, "https://unp-dev.s3.ap-southeast-1.amazonaws.com/nfts/pets/101267200100000139000001000122000041200600001450001650001650000.json");
    //     console2( erc721.ownerOf(0));
    //     assertEq(erc721.ownerOf(0), alice);
    //     assertEq(erc721.balanceOf(alice), 1);
    //     emit Transfer(address(0), alice, 1);
    //     // Revert mint if id is already minted
    // }

    // function test_getApproval() public {
    //     // Revert if token does not exist
    //     vm.prank(owner);
    //     erc721.mintNFT(alice, "https://unp-dev.s3.ap-southeast-1.amazonaws.com/nfts/pets/101267200100000139000001000122000041200600001450001650001650000.json");
      
    //     uint tokenId =  erc721.tokenCounter() - 1;
    //     assertEq(erc721.getApproved(tokenId), alice);
    //     console2.log("address  aproval",erc721.getApproved(tokenId));

    // }

     function test_approve_owner() public {
        // Revert if token does not exist
        // vm.expectRevert();
        vm.prank(owner);

        erc721.mintNFT(alice, "https://www.google.com");

        // Revert if not owner or approved for all
        vm.expectRevert();
        erc721.approve(bob, 0);

        // Approve if owner
        vm.expectEmit(true, true, true, false);
        emit Approval(alice, bob, 0);

        vm.prank(alice);
        erc721.approve(bob, 0);
        
        assertEq(erc721.getApproved(0), bob);
    }



}