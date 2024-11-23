// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;
import "./SafeMath.sol";

contract Escrow {
    using SafeMath for uint256;
    address public owner;
    mapping (address => uint256) public deposits;
    constructor() {
        owner = msg.sender;
    }
    modifier onlyOwner{
        require(owner == msg.sender , "you are not owner");
        _;
    }
    event depositEvent(address indexed payee,uint256 amount);
    event withdrawEvent(address indexed payee, uint256 amount); 
    function deposit (address payee) public  payable onlyOwner {
        uint256 amount = msg.value;
         deposits[payee] = deposits[payee].add(amount) ;
        emit depositEvent(payee,amount);
    }
    function withdraw (address payable  payee) public onlyOwner{
        uint256 amount = deposits[payee];
        deposits[payee] = 0;
        payee.transfer(amount);
        emit withdrawEvent(payee,amount);
    }
}