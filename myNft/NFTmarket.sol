// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";


contract NFTmarket is IERC721Receiver {
    mapping(uint => uint) public tokenPrice;
    mapping(uint => address) public tokenSeller;
    address public immutable token;
    address public immutable nftToken;
    constructor (address _token, address _nftToken){
        token = _token;
        nftToken = _nftToken;
    }
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4){
        return this.onERC721Received.selector;
    }

    function list(uint tokenId, uint amount) public {
        // safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;

        IERC721(nftToken).safeTransferFrom(msg.sender, address(this), tokenId, '');
        tokenSeller[tokenId] = msg.sender;
        tokenPrice[tokenId] = amount;
    }

    function buy(uint tokenId) public {

        require(IERC721(nftToken).ownerOf(tokenId) == address(this), "sell out");
        IERC20(token).transferFrom(msg.sender, tokenSeller[tokenId], tokenPrice[tokenId]);
        IERC721(nftToken).transferFrom(tokenSeller[tokenId], msg.sender, tokenId);
    }


}