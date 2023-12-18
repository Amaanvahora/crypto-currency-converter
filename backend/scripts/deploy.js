// deploy.js

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const CurrencyConverter = await ethers.getContractFactory("CurrencyConverter");

  try {
    const currencyConverter = await CurrencyConverter.deploy();
    console.log("CurrencyConverter address:", currencyConverter.target);
  } catch (error) {
    console.error("Error deploying contract:", error);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
