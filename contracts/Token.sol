// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
contract Token is ERC1155 {
    uint256 public constant TOKEN = 0;
    address private owner;
    constructor() ERC1155("") {
        owner = msg.sender;
        _mint(msg.sender, TOKEN, 170000000 * 10 ** 18, "");
    }
 modifier onlyOwner() {
        require(msg.sender == owner, "only owner can call this function");
        _;
    }
    function mint(uint256 amount) public onlyOwner{
        _mint(msg.sender, TOKEN, amount * 10 ** 18, "");
    }
}