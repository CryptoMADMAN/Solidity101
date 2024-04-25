// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import './BaseERC20.sol';

contract BaseERC20WithCallBack is BaseERC20 {

    constructor(string memory _name, string memory _symbol, uint _totalSupply) BaseERC20(_name, _symbol, _totalSupply){

    }

    function transferWithCallBack(address _to, uint _value) public returns (bool){
        bool b = transfer(_to, _value);
        // _to.code.length>0去判断是否_to是否是合约
        if (_to.code.length > 0) {
            // 使用 call 来动态调用 tokensReceived 方法
            (bool success,) = _to.call(abi.encodeWithSignature('tokensReceived(address,uint)', msg.sender, _value));
        }
        return b;
    }

    function transferWithCallBack(address _to, uint _value, uint tokenId) public returns (bool){
        bool b = transfer(_to, _value);
        if (_to.code.length > 0) {
            // 使用 call 来动态调用 tokensReceived 方法
            (bool success,) = _to.call(abi.encodeWithSignature('tokensReceived(address,uint)', msg.sender, _value, tokenId));
        }
        return b;
    }
}
