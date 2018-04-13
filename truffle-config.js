import HDWalletProvider from 'truffle-hdwallet-provider';

module.exports = {
  networks: {
    dev: {
      provider: new HDWalletProvider()
    }
  }
};
