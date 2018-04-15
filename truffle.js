let HDWalletProvider = require('truffle-hdwallet-provider');

let mnemonic = "citizen spread heart traffic accuse umbrella analyst afford donor remove shine agent";

module.exports = {
  networks: {
    development: {
      // provider: HDWalletProvider(mnemonic, "http://localhost:8545"),
      host: 'localhost',
      port: 8545,
      network_id: 5777,
      gas: 19000000,
    }
  }
};
