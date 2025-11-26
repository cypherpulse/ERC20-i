//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract ManualToken {
    mapping(address => uint256) private s_balances;

    function name() public pure returns (string memory) {
        return "BradleyUSD";
    }

    function symbol() public pure returns (string memory) {
        return "BUSD";
    }

    function totalSupply() public pure returns (uint256) {
        return 100 ether; // 100 tokens with 18 decimals
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return s_balances[_owner];
    }

    function transfer(address _to, uint256 _amount) public returns (bool) {
        require(s_balances[msg.sender] >= _amount, "Insufficient balance");
        uint256 previousBalances = s_balances[msg.sender] + s_balances[_to];
        s_balances[msg.sender] -= _amount;
        s_balances[_to] += _amount;
        require(s_balances[msg.sender] + s_balances[_to] == previousBalances, "Transfer failed");
        return true;
    }
}
