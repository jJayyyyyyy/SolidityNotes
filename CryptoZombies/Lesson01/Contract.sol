pragma solidity ^0.4.25;

contract ZombieFactory {
	uint dnaDigits;
	// ** 表示指数，下面一行的意思是 10 的 16 次方
	// 也就是 dnaModulus 是一个 16位的十进制数
	uint dnaModulus = 10 ** dnaDigits;

	struct Zombie {
		string name;
		uint dna;
	}

	// You can declare an array as public, and Solidity will automatically create a getter method for it
	// Other contracts would then be able to read from, but not write to, this array.
	// So this is a useful pattern for storing public data in your contract.
	Zombie[] public zombies;

	// event 事件, 
	// 完成一件事后可以生成事件，前端就可以捕获这个事件，从而改变前端页面
	event NewZombie(uint zombieId, string name, string dna);

	// 方法的形参一般以下划线开头
	// 私有方法也用下划线开头
	function _createZombie(string _name, uint _dna) private {
		uint id = zombies.push(Zombie(_name, _dna)) - 1;
		// fire an event to let the app know the function was called:
		emit NewZombie(id, _name, _dna);
	}

	// view 表示不会修改任何数据
	// pure 表示不会读取任何数据
	function _generateRandomDna(string _str) private view returns (uint) {
		// Ethereum has the hash function keccak256 built in, which is a version of SHA3
		// A hash function basically maps an input into a random 256-bit hexidecimal number
		uint rand = uint(keccak256(abi.encodePacked(_str)));
		return rand % dnaModulus;
	}

	// 测试能否通过名字随机生成 zombie
	function createRandomZombie(string _name) public {
		uint randDna = _generateRandomDna(_name);
		_createZombie(_name, randDna);
	}
}


