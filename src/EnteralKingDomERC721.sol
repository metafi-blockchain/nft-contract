// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {ERC721URIStorage} from "lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import { ERC721 } from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract EnteralKingDomERC721 is ERC721URIStorage, Ownable {
    
    uint256 private _tokenCounter;

    event NFTMinted(address indexed recipient, uint256 tokenId, string uri);
    event NFTBurned(uint256 tokenId);

    constructor(address _owner, string memory _name, string memory _symbol) ERC721(_name, _symbol) Ownable(_owner) {
        _tokenCounter = 0;
    }
    
    // Mint a single NFT
    function mintNFT(address recipient, string memory uri) public onlyOwner {
        _mintNft(recipient, uri);
    }
    
    // Mint batch NFTs
    function mintBatchNFT(address[] memory recipients, string[] memory uris) public onlyOwner {
        require(recipients.length > 0, "Recipients length is 0");
        require(recipients.length == uris.length, "Recipients and URIs length mismatch");

        uint256 len = recipients.length;

        for (uint256 i = 0; i < len; ++i) {
            _mintNft(recipients[i], uris[i]);
        }
    }

    // Internal minting function
    function _mintNft(address recipient, string memory uri) internal {
        uint256 newTokenId = _tokenCounter;
        _mint(recipient, newTokenId);
        _setTokenURI(newTokenId, uri);
        _tokenCounter += 1;
        emit NFTMinted(recipient, newTokenId, uri);
    }

    // Burn an NFT, with option for token holder to burn their token
    function burn(uint256 tokenId) public {
        // require(_isApprovedOrOwner(msg.sender, tokenId), "Caller is not owner nor approved");
        _burn(tokenId);
        emit NFTBurned(tokenId);
    }

    // Get total number of minted tokens (for external visibility)
    function totalMinted() public view returns (uint256) {
        return _tokenCounter;
    }
}