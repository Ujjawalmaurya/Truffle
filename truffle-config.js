module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",     // Ganache CLI host
      port: 8545,            // Ganache CLI port
      network_id: "*"        // Match any network id
    }
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.20",    // use a modern version
    }
  }
};
