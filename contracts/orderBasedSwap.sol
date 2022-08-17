// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract OrderBasedSwap {
    uint ID = 1;

    struct Order {
        uint amountIn;
        uint amountOut;
        address contractIn;
        address contractOut;
        uint id;
        address initiator;
        address executor;
        bool status;

    }

    mapping (uint => Order) orderBook;

    event CreateOrder(uint _id, address _initiator);

    mapping (address=>bool) public tradeableTokens;

    function createOrder(uint _amountIn, uint _amountOut, address _contractIn, address _contractOut)  external {
        require(address(_contractIn) != address(0), "");
        require(address(_contractOut) != address(0), "");

        IERC20 tokenIn = IERC20(_contractIn);
        require(tokenIn.balanceOf(msg.sender) >= _amountIn, "");
        tokenIn.approve(address(this), _amountIn);
        require(tokenIn.allowance(msg.sender, address(this)) >= _amountIn, "");
        tokenIn.transferFrom(msg.sender, address(this), _amountIn);

        Order storage order = orderBook[ID];
        order.amountIn = _amountIn;
        order.amountOut = _amountOut;
        order.contractIn = _contractIn;
        order.contractOut = _contractOut;
        order.id = ID;
        order.initiator = msg.sender;

        emit CreateOrder (ID, msg.sender);
        ID++;

    }

    function swap(uint id) external {
        Order storage order = orderBook[id];

        require(!(order.status), "Order Closed");
        IERC20 tokenIn = IERC20(order.contractIn);
        IERC20 tokenOut = IERC20(order.contractOut);
        require(tokenOut.balanceOf(msg.sender) >= order.amountOut, "");
        tokenOut.approve(address(this), order.amountOut);
        require(tokenOut.allowance(msg.sender, address(this)) >= order.amountIn, "");

        order.status = true;
        order.executor = msg.sender;

        tokenOut.transferFrom(msg.sender, order.initiator, order.amountOut);
        tokenIn.transferFrom(address(this), msg.sender, order.amountIn);

    }
}