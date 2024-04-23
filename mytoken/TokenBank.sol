// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./BaseERC20.sol";  // 假设BaseERC20合约位于同一文件夹

contract TokenBank {
    BaseERC20 public token;
    mapping(address => uint256) public deposits;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    constructor(address _tokenAddress) {
        token = BaseERC20(_tokenAddress);
    }

    function deposit(uint256 _amount) public {
        require(_amount > 0, "Amount must be greater than 0");
        require(token.balanceOf(msg.sender) >= _amount, "Insufficient token balance");
        require(token.transferFrom(msg.sender, address(this), _amount), "Transfer failed");

        deposits[msg.sender] += _amount;
        emit Deposited(msg.sender, _amount);
    }

    function withdraw(uint256 _amount) public {
        require(_amount > 0, "Amount must be greater than 0");
        require(deposits[msg.sender] >= _amount, "Insufficient deposit balance");

        deposits[msg.sender] -= _amount;
        require(token.transfer(msg.sender, _amount), "Transfer failed");

        emit Withdrawn(msg.sender, _amount);
    }
}
