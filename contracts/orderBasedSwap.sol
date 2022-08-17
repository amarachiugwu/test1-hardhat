// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract OrderBasedToken {
    uint ID = 1;

    struct Order {
        uint amountIn;
        uint amountOut;
        address contractIn;
        address contractOut;
        uint id;
        address initiator;
        address executor;

    }

    mapping (address => Order) orderBook;

    // event createOrderEvent(uint _id, address _initiator, address _executor);

    mapping (address=>bool) public tradeableTokens;

    function createOrder(uint _amt, address _initiator, address _executor)  external {
        
    }
}



