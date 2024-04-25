// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./BaseERC20.sol";

interface IERC20 {
    function balanceOf(address _owner) external  view returns(uint);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success) ;
    function transfer(address _to, uint256 _value) external returns (bool success);
}

contract TokenBank {
    // BaseERC20 public token;
    mapping(address => mapping(address=>uint256)) public depositBalances;

    constructor() {
        // token = new BaseERC20();
    }

    function deposit(address _token,uint256 amount) public {

        bool sent = IERC20(_token).transferFrom(msg.sender, address(this), amount);
        require(sent, "Token transfer failed");
        depositBalances[msg.sender][_token] += amount;
    }

    function withdraw(address _token,uint256 amount) public {

        require(depositBalances[msg.sender][_token] >= amount, "Insufficient balance");
        depositBalances[msg.sender][_token] -= amount;
        bool sent = IERC20(_token).transfer(msg.sender, amount);
        require(sent, "Token transfer failed");
    }
}
