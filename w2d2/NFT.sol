// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyERC721 is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("manson", "MSN") {}

    //  QmZNFPwox146ohY93ViFD8omSThRAVYF1A96MNHbWoa2Nr

    // ipfs://QmT4YDZ2dgTSpfHwPndnSuvHrAXNvtDBKNDUwN8nuZiVHT
    function mint(address student, string memory tokenURI)
    public
    returns (uint256)
    {
        uint256 newItemId = _tokenIds.current();
        _mint(student, newItemId);
        _setTokenURI(newItemId, tokenURI);

        _tokenIds.increment();
        return newItemId;
    }
}