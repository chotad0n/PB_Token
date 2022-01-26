pragma solidity >=0.4.22 <0.9.0;

import "./PBToken.sol";

contract PBTokenSale {
     address admin;//not public since we dont want to expose the admin
     PBToken public tokenContract;
     uint256 public tokenPrice;
     uint256 public tokensSold;

     event Sell(address _buyer, uint256 _amount);

    constructor (PBToken _tokenContract, uint256 _tokenPrice) public {
         admin = msg.sender;
         tokenContract = _tokenContract;//to purachase token
         tokenPrice = _tokenPrice;
    }

    //from ds math
    function multiply(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }

    function buyTokens(uint256 _numberOfTokens) public payable {
        require(msg.value == multiply(_numberOfTokens, tokenPrice));
        require(address(this).balance >= _numberOfTokens);
        require(tokenContract.transfer(msg.sender, _numberOfTokens));

        tokensSold += _numberOfTokens;

        emit Sell(msg.sender, _numberOfTokens);
    }

    function endSale() public {
        require(msg.sender == admin);
        require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));
        
        // UPDATE: Let's not destroy the contract here
        // Just transfer the balance to the admin
        address payable addr = payable(address(admin));
        addr.transfer(address(this).balance);    
    }
}