pragma solidity ^0.4.25;

import "./zombiefactory.sol";

contract KittyInterface {
	function getKitty(uint256 _id) external view returns (
		bool isGestating,
		bool isReady,
		uint256 cooldownIndex,
		uint256 nextActionAt,
		uint256 siringWithId,
		uint256 birthTime,
		uint256 matronId,
		uint256 sireId,
		uint256 generation,
		uint256 genes
	);
	// 接口方法，没有实现，因此没有 {}, 只在最后加分号
}

contract ZombieFeeding is ZombieFactory {

	address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
	KittyInterface kittyContract = KittyInterface(ckAddress);

	function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) public {
		// 首先确保只有当前 zombie 的主人才能操作
		require(msg.sender == zombieToOwner[_zombieId]);
		// 获得当前 zombie
		Zombie storage myZombie = zombies[_zombieId];
		// 处理目标 dna
		_targetDna = _targetDna % dnaModulus;
		uint newDna = (myZombie.dna + _targetDna) / 2;

		if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
			// 使最后两位变成 99
			newDna = newDna - newDna % 100 + 99;
		}

		// 生成新的 zombie
		_createZombie("NoName", newDna);
	}

	function feedOnKitty(uint _zombieId, uint _kittyId) public {
		uint kittyDna;
		(,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
		feedAndMultiply(_zombieId, kittyDna, "kitty");
	}
}
