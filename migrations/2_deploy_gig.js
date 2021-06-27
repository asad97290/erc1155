const Token = artifacts.require("Token");
const PreSale = artifacts.require("PreSale");

module.exports = async function (deployer) {
  await deployer.deploy(Token);
  let token = await Token.deployed()
  await deployer.deploy(PreSale,token.address,1624721692,1624876492,"10000000000000000"); // 0.01 ether
  let preSale = await PreSale.deployed()
  token.setApprovalForAll(preSale.address,true)
};
