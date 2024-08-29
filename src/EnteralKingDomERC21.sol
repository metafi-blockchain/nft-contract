// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {ERC721URIStorage} from "lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import { ERC721 } from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract EnteralKingDomERC21 is ERC721URIStorage, Ownable {
    
    uint256 private _tokenCounter;

    event NFTMinted(address indexed recipient, uint256 tokenId, string uri);
    event NFTBurned(uint256 tokenId);

    constructor(address _owner, string memory  _name , string memory _symbol) ERC721(_name, _symbol) Ownable(_owner){
        _tokenCounter = 0;
    }
    
    function mintNFT(address recipient, string memory uri) public onlyOwner {
        uint256 newTokenId = _tokenCounter;
        _mint(recipient, newTokenId);
        _setTokenURI(newTokenId, uri);
        _tokenCounter += 1;
        emit NFTMinted(recipient, newTokenId, uri);
    }

    function burn(uint256 tokenId) public onlyOwner {
        _burn(tokenId);
        emit NFTBurned(tokenId);
    }

    function tokenCounter() public view returns (uint256) {
        return _tokenCounter;
    }
}