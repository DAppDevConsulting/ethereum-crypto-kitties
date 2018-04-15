module.exports = {
  networks: {
    development: {
      // provider: HDWalletProvider(mnemonic, "http://localhost:8545"),
      host: 'localhost',
      port: 7545,
      network_id: 5777,
      gas: 4000000,
    }
  }
};
