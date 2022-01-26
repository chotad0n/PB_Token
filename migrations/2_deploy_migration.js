var PBToken = artifacts.require("./PBToken.sol");
var PBTokenSale = artifacts.require("./PBTokenSale.sol");

module.exports = function (deployer) {
  deployer.deploy(PBToken, 1000000).then(function(){
    var tokenPrice = 1000000000000000;//token price is 0.001 ether
    return deployer.deploy(PBTokenSale, PBToken.address, tokenPrice);
  });
};
