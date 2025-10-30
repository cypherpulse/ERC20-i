
//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract ManualToken{
    function name() public pure returns(string memory) {
        return "ManualToken";
    }

    function symbol() public pure returns(string memory) {
        return "MTK";
    }

    function totalSupply() public pure returns(uint256){
        return 100 ether; // 100 tokens with 18 decimals
    }

    function decimals() public pure returns(uint8){
        return 18;
    }
}