// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "lib/forge-std/src/Test.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {BasedBradley} from "../src/BasedBradley.sol";

contract BasedBradleyTest is Test {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    BasedBradley public basedBradley;
    DeployOurToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
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
        assertEq(ourToken.balanceOf(msg.sender), deployer.INITIAL_SUPPLY() - STARTING_BALANCE - transferAmount);
    }

    function testTransferToZeroAddress() public {
        uint256 transferAmount = 100 ether;

        vm.prank(msg.sender);
        vm.expectRevert();
        ourToken.transfer(address(0), transferAmount);
    }

    function testTransferInsufficientBalance() public {
        address recipient = makeAddr("recipient");
        uint256 transferAmount = deployer.INITIAL_SUPPLY() + 1;

        vm.prank(msg.sender);
        vm.expectRevert();
        ourToken.transfer(recipient, transferAmount);
    }

    function testApprove() public {
        address spender = makeAddr("spender");
        uint256 approvalAmount = 500 ether;

        vm.prank(msg.sender);
        ourToken.approve(spender, approvalAmount);

        assertEq(ourToken.allowance(msg.sender, spender), approvalAmount);
    }

    function testTransferFrom() public {
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
        ourToken.transferFrom(charlie, dave, transferAmount);

        assertEq(ourToken.balanceOf(charlie), 0);
        assertEq(ourToken.balanceOf(dave), transferAmount);
        assertEq(ourToken.allowance(charlie, dave), approvalAmount - transferAmount);
    }

    function testTransferFromInsufficientAllowance() public {
        address owner = makeAddr("owner");
        address spender = makeAddr("spender");
        uint256 approvalAmount = 50 ether;
        uint256 transferAmount = 100 ether;

        vm.prank(msg.sender);
        ourToken.transfer(owner, approvalAmount);

        vm.prank(owner);
        ourToken.approve(spender, approvalAmount);

        vm.prank(spender);
        vm.expectRevert();
        ourToken.transferFrom(owner, spender, transferAmount);
    }

    function testTransferEvent() public {
        address recipient = makeAddr("recipient");
        uint256 transferAmount = 100 ether;

        vm.prank(msg.sender);
        vm.expectEmit(true, true, false, true);
        emit Transfer(msg.sender, recipient, transferAmount);
        ourToken.transfer(recipient, transferAmount);
    }

    function testApprovalEvent() public {
        address spender = makeAddr("spender");
        uint256 approvalAmount = 200 ether;

        vm.prank(msg.sender);
        vm.expectEmit(true, true, false, true);
        emit Approval(msg.sender, spender, approvalAmount);
        ourToken.approve(spender, approvalAmount);
    }

    function testNameAndSymbol() public {
        assertEq(ourToken.name(), "BasedBradley");
        assertEq(ourToken.symbol(), "BBD");
    }

    function testDecimals() public {
        assertEq(ourToken.decimals(), 18);
    }
}
