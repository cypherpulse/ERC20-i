
//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract ManualToken{
    function name() public pure returns(string memory) {
        return "ManualToken";
    }

    function symbol() public pure returns(string memory) {
        return "MTK";
    }
}