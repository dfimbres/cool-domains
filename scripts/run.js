const main = async () => {
    const contractFactory = await hre.ethers.getContractFactory('Domains');
    const domainContract = await contractFactory.deploy();
    await domainContract.deployed();

    console.log('Contract deployed to: ', domainContract.address)
}

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
}

runMain();