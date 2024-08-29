// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {EnteralKingDomERC21} from "./EnteralKingDomERC21.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract EnteralKingdomNFTFactory2 is Ownable {
   
    constructor() Ownable(msg.sender) {}

    mapping(uint => address) public nfts;
    
    event Deployed(address addr);

    
    function deploy(address _owner, uint256 _salt, string calldata _name, string calldata _symbol) public onlyOwner returns (address) {
        
        require(nfts[_salt] == address(0), "Contracts exits");

        EnteralKingDomERC21 con =
            new EnteralKingDomERC21{salt: bytes32(_salt)}(_owner, _name, _symbol );
        emit Deployed(address(con));
      
        nfts[_salt] = address(con);
        return address(con);
    }

    function getContractAddress(
        address  _owner,
        string calldata _name,
        string calldata _symbol,
        uint256 _salt
    ) external view returns (address) {
        bytes memory bytecode = getByteCodeContract(_owner, _name, _symbol);
        bytes32 hash = keccak256(
            abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(bytecode))
        );
        return address(uint160(uint256(hash)));
    }

    function getByteCodeContract( address _owner, string calldata _name,  string calldata _symbol) public pure  returns (bytes memory) {
        return  abi.encodePacked(
            type(EnteralKingDomERC21).creationCode,
            abi.encode(_owner, _name, _symbol)
        ); 
    }

    
}