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
