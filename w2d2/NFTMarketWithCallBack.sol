// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


import "./NFTMarket.sol";


contract NFTMarketWithCallBack is NFTMarket {

  constructor(address _token, address _nftToken) NFTMarket(_token, _nftToken) {
        // 这里可以加入子合约特有的初始化逻辑，如果有的话
    }
    //BaseERC20WithCallBack.transferWithCallBack
    function tokensReceived(address sender, uint256 value, bytes memory data) external returns (bool){
        //校验，必须从ERC20合约回调过来
        require(msg.sender == address(token), "no auth");
        (uint256 tokenId) = abi.decode(data, (uint256));

        require(nftToken.ownerOf(tokenId) == address(this), "not owner");
        require(tokenSeller[tokenId]!= address(0), "not list");
        require(value >= tokenIdPrice[tokenId], "amount less than price");
        token.transferFrom(address(this), tokenSeller[tokenId], tokenIdPrice[tokenId]);
        nftToken.safeTransferFrom(address(this), sender, tokenId);
        delete tokenSeller[tokenId];
        delete tokenIdPrice[tokenId];
        return true;
    }
}
