// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "./TokenBank.sol";

contract TokenBankWithCallBack is TokenBank{
    IERC20 public IERC20Token;
    constructor(address _token) TokenBank(){

        IERC20Token=IERC20(_token);

    }

    event TokenReceived(address sender,uint value);
    function tokenReceived(address sender,uint value) public {
        require(msg.sender==address(IERC20Token),'no auth');
        depositBalances[sender][address(IERC20Token)]+=value;

    }
}