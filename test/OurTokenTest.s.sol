// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "lib/forge-std/src/Test.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {OurToken} from "../src/OurToken.sol";

contract OurTokenTest is Test{
    OurToken public ourToken;
    DeployOurToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public{
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        ourToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public {
        assertEq(STARTING_BALANCE, ourToken.balanceOf(bob));
    }

    function testAllowancesWorks() public {
        uint256 initialAllowance = 1000;

        //Bob approves Alice to spend tokens on his behalf
        vm.prank(bob);
        ourToken.approve(alice, initialAllowance);
        
        uint256 transferAmount = 500;
        
        vm.prank(alice);
        ourToken.transferFrom(bob, alice, transferAmount);

        assertEq(ourToken.balanceOf(alice), transferAmount);
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }

    function testTransfer() public {
        address charlie = makeAddr("charlie");
        uint256 transferAmount = 100 ether;

        vm.prank(msg.sender);
        ourToken.transfer(charlie, transferAmount);

        assertEq(ourToken.balanceOf(charlie), transferAmount);
        assertEq(ourToken.balanceOf(msg.sender),deployer.INITIAL_SUPPLY() - STARTING_BALANCE - transferAmount);
    }

    function testTransferFrom() public{
        address charlie = makeAddr("charlie");
        address dave = makeAddr("dave");
        uint256 approvalAmount = 200 ether;
        uint256 transferAmount = 150 ether;

       // Transfer some tokens to owner first
       vm.prank(msg.sender);
       ourToken.transfer(charlie, approvalAmount);

       // Charlie approves Dave to spend tokens on his behalf
       vm.prank(charlie);
       ourToken.approve(dave, approvalAmount);

       // Dave transfers tokens from Charlie to himself
       vm.prank(dave);
    }
}