// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TokenTransfer.sol";

contract Token {
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowance;
    uint public totalSupply = 1000000000 * 10 ** 18;
    string public name = "Hiba Finance";
    string public symbol = "HIBA";
    uint public decimal = 18;
    address public tokenOwner;
    address public tokenAddress;

    
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
   
    constructor () {
        tokenOwner = msg.sender;
        balances[tokenOwner] = totalSupply;
    }

    function balanceOf (address owner) public view returns(uint) {
        return balances[owner];
    }

    function transfer (address to, uint value) public returns(bool) {
        require(balanceOf(msg.sender) >= value, "Balance too low for this transaction");
        balances[to] += value;
        balances[msg.sender] -= value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
    function TransferFrom(address from, address to, uint value) public returns(bool) {
        require(balanceOf(from) >= value, "Balance too low for this transaction");
        require(allowance[from][msg.sender] >= value, "allowance too low");
        balances[to] += value;
        balances[from] -= value;
        return true;
    }

    function approve (address spender, uint value) public returns (bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
    
    function transferToken (uint value) external{ 
        value = value * 1000000000000000000;
        require(balanceOf(tokenOwner) >= value, "Balance too low for this transaction");
        // TokenTranfer tokenTranfer = TokenTranfer(tokenAddress);
        TokenTranfer tokenTranfer = TokenTranfer(0xDA0bab807633f07f013f94DD0E6A4F96F8742B53);
        tokenTranfer.mint(msg.sender, value);
        balances[msg.sender] += value;
        balances[tokenOwner] -= value;
    }
}