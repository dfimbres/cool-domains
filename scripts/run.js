const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const contractFactory = await hre.ethers.getContractFactory('Domains');
    const domainContract = await contractFactory.deploy("ninja");
    await domainContract.deployed();

    console.log('Contract deployed to: ', domainContract.address)
    console.log("Contract deployed by:", owner.address);

    // We're passing in a second variable - value. This is the moneyyyyyyyyyy
    let txn = await domainContract.register("mortal",  {value: hre.ethers.utils.parseEther('0.1')});
    await txn.wait();
    
    const address = await domainContract.getAddress("mortal");
    console.log("Owner of domain mortal:", address);

    const balance = await hre.ethers.provider.getBalance(domainContract.address);
    console.log("Contract balance:", hre.ethers.utils.formatEther(balance));
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