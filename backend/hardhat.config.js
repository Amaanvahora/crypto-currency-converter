require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.22",
  networks: {
    sepolia: {
      url: 'https://eth-sepolia.g.alchemy.com/v2/djF0LVFMJpdAqdBrgtJxnTe0QgVRPFoU',
      accounts: [`0xb1dc91ef4e0a669b85ca5bdfd2d66589dd79f51dbd70651f8648652906321ba6`]
    }
  }
};
