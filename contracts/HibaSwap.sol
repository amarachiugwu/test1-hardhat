// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
 

contract HibaSwap {
    
    mapping(address => uint) public balances;
    address payable public owner;
    
    constructor () {
        owner = payable(msg.sender);
    }

    

    
    function swap() public payable {

        require(msg.value > 0, 'insufficent amount');
        owner.transfer(msg.value);
        balances[msg.sender] += msg.value;

    }
    
}