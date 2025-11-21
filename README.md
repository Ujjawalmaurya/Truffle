# Truffle

## Step 0: install required tools

``` bash
npm install -g truffle
npm install -g ganache
```

&

Start a local blockchain (Ganache CLI)

``` bash 
npx ganache@latest -p 8545

```
> Why port `8545`?? bcz Documentation says

## Step 1: Initialize project

 if truffle global:
```truffle init```

or using npx:
```npx truffle@latest init```

## Step 2: Configure Truffle network (truffle-config.js)

``` js
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

```

## Step 3: Create a Solidity contract
``` solidity
pragma solidity ^0.8.0;

contract SimpleBank {
    address public owner;
    uint public storedValue;

    event ValueChanged(address indexed setter, uint oldValue, uint newValue);
    event Deposit(address indexed from, uint amount);
    event Withdrawal(address indexed to, uint amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }

    function setValue(uint _value) public {
        uint old = storedValue;
        storedValue = _value;
        emit ValueChanged(msg.sender, old, _value);
    }

    function getValue() public view returns (uint) {
        return storedValue;
    }

    // pure function example
    function double(uint x) public pure returns (uint) {
        return x * 2;
    }

    // payable deposit
    function deposit() public payable {
        require(msg.value > 0, "no value");
        emit Deposit(msg.sender, msg.value);
    }

    // owner-only withdraw
    function withdraw(uint amount) public onlyOwner {
        require(amount <= address(this).balance, "insufficient balance");
        payable(owner).transfer(amount);
        emit Withdrawal(owner, amount);
    }

    // fallback to accept ETH
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }
}

```
> This has constructor, state variables, modifier, events, view/pure, payable, receive/fallback.

## Step 4: Add Migration

``` js
const SimpleBank = artifacts.require("SimpleBank");

module.exports = function (deployer) {
  deployer.deploy(SimpleBank);
};

```

## Step 5: Install test helpers (Don't know why, just following documentation)

``` bash
npm init -y
npm install --save-dev truffle-assertions

```

## Step 6: Compile and deploy With Ganache running

``` bash
# using truffle
truffle compile
truffle migrate --network development --reset

# or using npx
npx truffle@latest compile
npx truffle@latest migrate --network development --reset


```

