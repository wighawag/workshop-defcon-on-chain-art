import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const {deployments, getNamedAccounts} = hre;
  const {deploy} = deployments;

  const {deployer} = await getNamedAccounts();

  const dev = !hre.network.live;

  await deploy('SimpleERC721', {
    from: deployer,
    log: true,
    proxy: dev,
  });
};
export default func;
func.tags = ['SimpleERC721'];
