// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract PreSale {
    IERC1155 private token;
    uint256 public saleStart;
    uint256 public saleEnd;
    uint256 public tokenPrice;
    address private owner;

    constructor(
        IERC1155 _token,
        uint256 _saleStart,
        uint256 _saleEnd,
        uint256 _tokenPrice
    ) {
        token = _token;
        saleStart = _saleStart;
        saleEnd = _saleEnd;
        tokenPrice = _tokenPrice;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can call this function");
        _;
    }

    function buyToken() public payable {
        require(msg.sender != address(0), "caller is the zero address");
        require(msg.value > 0, " Amount is 0");
        require(
            block.timestamp >= saleStart && block.timestamp <= saleEnd,
            "Presale period is ended"
        );
        
        uint256 wei_unit = (1*10**uint256(18))/tokenPrice;
        uint256 amount = ((msg.value*((wei_unit)))/(1 ether))*(10 ** uint256(18));

        token.safeTransferFrom(owner,msg.sender, 0, amount, "");
    }

    function setTokenPrice(uint256 _tokenPrice) public onlyOwner {
        tokenPrice = _tokenPrice;
    }

    function setStartTime(uint256 _startTime) public onlyOwner {
        saleStart = _startTime;
    }

    function setEndTime(uint256 _endTime) public onlyOwner {
        saleEnd = _endTime;
    }

    function withdrawEth() public onlyOwner {
        require(block.timestamp >= saleEnd, "can not withdraw before preSale");
        payable(msg.sender).transfer(address(this).balance);
    }

    receive() external payable {}
}
