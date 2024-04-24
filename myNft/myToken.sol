// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";

interface TokenRecipient {
    function tokensReceived(address sender, uint amount) external returns (bool);
}

contract MyERC20Callback is ERC20 {
    using Address for address;

    constructor() ERC20("MyERC20", "MyERC20") {
        _mint(msg.sender, 1000 * 10 ** 18);
    }

     function isContract(address account) internal view returns (bool) {
         // 按照Solidity文档，这种方法不能在构造函数中，因为合约自身还在创建中。
         uint256 size;
         assembly { size := extcodesize(account) }
         return size > 0;
     }


     function transferWithCallback(address recipient, uint256 amount) external returns (bool) {
         _transfer(msg.sender, recipient, amount);

         if (isContract(recipient)) {
             bool rv = TokenRecipient(recipient).tokensReceived(msg.sender, amount);
             require(rv, "No tokensReceived");
         }

         return true;
     }


}