// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyERC721 is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721(unicode"manson", "MSN") {}

    function mint(address addr, string memory tokenURI) public returns (uint256){
        uint256 id = _tokenIds.current();
        _mint(addr, id);
        _setTokenURI(id, tokenURI);

        _tokenIds.increment();
        return id;
    }
}