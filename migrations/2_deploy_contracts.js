var CryptoKittiesContract = artifacts.require("./CryptoKitties.sol");

module.exports = function(deployer) {
  deployer.deploy(CryptoKittiesContract, "KittyToken", "CKT");
};
