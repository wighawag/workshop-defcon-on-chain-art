import {expect} from './chai-setup';
import {ethers, deployments, getUnnamedAccounts} from 'hardhat';
import {IERC721} from '../typechain';
import {setupUsers} from './utils';

const setup = deployments.createFixture(async () => {
  await deployments.fixture('SimpleERC721');
  const contracts = {
    SimpleERC20: <IERC721>await ethers.getContract('SimpleERC721'),
  };
  const users = await setupUsers(await getUnnamedAccounts(), contracts);
  return {
    ...contracts,
    users,
  };
});

describe('SimpleERC721', function () {
  it('mint succeed', async function () {
    const {users, SimpleERC20} = await setup();
    // await simpleERC20Beneficiary.SimpleERC20.transfer(users[1].address, 1);

    // await expect(simpleERC20Beneficiary.SimpleERC20.transfer(users[1].address, 1))
    //   .to.emit(SimpleERC20, 'Transfer')
    //   .withArgs(simpleERC20Beneficiary.address, users[1].address, 1);
  });
});
