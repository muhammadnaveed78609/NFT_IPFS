const { ethers } = require("hardhat");
require("dotenv").config();

const Deploy = async () => {
  const metadataURL = "ipfs:QmcoELACZPk25PwQq5y9Tc5arF5u7dStJV1oxfRJbqfXde/";
  let contract = await ethers.getContractFactory("NFT");
  let Nftcontract = await contract.deploy(metadataURL);
  await Nftcontract.deployed();
  console.log("Contract Address : ", Nftcontract.address);
};

Deploy()
  .then(() => process.exit(1))
  .catch((error) => {
    console.error(error);
    process.exit(0);
  });
