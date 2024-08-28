// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;
import {Test} from "forge-std/Test.sol";
import {EnteralKingDomERC21} from '../src/EnteralKingDomERC21.sol';

contract EnteralKingDomERC21Test is Test {

    EnteralKingDomERC21  private  erc721;

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
        erc721 = new EnteralKingDomERC21("MyNFT", "MNFT");
        vm.label(address(erc721), "ERC721");

    }

    function test_intialization() public  view{
        assertEq(erc721.name(), "MyNFT");
        assertEq(erc721.symbol(), "MNFT");
    }

    
    function test_ownerOf_non_existing_id() public {
        vm.expectRevert();
        erc721.ownerOf(0);
    }

    function test_balanceOf() public {
        vm.expectRevert();
        erc721.balanceOf(address(0));
        assertEq(erc721.balanceOf(address(1)), 0);
    }

    function test_mintNFT() public {
        // Revert mint if id is already minted
        uint256 tokenId = 0;
        erc721.mintNFT(address(this), "https://www.google.com");
        assertEq(erc721.ownerOf(tokenId), address(this)); 
   

        erc721.mintNFT(alice, "https://www.google.com");

        assertEq(erc721.ownerOf(1), alice);
        assertEq(erc721.balanceOf(alice), 1);
        emit Transfer(address(0), alice, 1);
        // Revert mint if id is already minted
    }

    function test_getApproval() public {
        // Revert if token does not exist
        vm.expectRevert();
        // erc721.getApproved((0));
        erc721.mintNFT(alice, "https://www.google.com");

        assertEq(erc721.getApproved(0), alice);

    }

     function test_approve_owner() public {
        // Revert if token does not exist
        vm.expectRevert();
        vm.prank(alice);

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