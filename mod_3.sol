// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract mod_3 {
    string public name;
    string public symbol;
    mapping(address => uint256) public balanceOf;

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event TokensMinted(address indexed account, uint256 amount);
    event TokensBurned(address indexed account, uint256 amount);

    constructor(string memory tokenName, string memory tokenSymbol) {
        name = tokenName;
        symbol = tokenSymbol;
    }

    function mint(address account, uint256 amount) public {
        require(account != address(0), "Invalid address");
        balanceOf[account] += amount;
        emit TokensMinted(account, amount);
    }

    function burn(uint256 amount) public {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        emit TokensBurned(msg.sender, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        require(sender != address(0), "Transfer from the zero address is not allowed");
        require(recipient != address(0), "Transfer to the zero address is not allowed");
        require(amount <= balanceOf[sender], "Insufficient balance");
       

        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
              
    emit Transfer(sender, recipient, amount);
        return true;
    }

    function transfer(address recipient, uint256 amount) public {
        require(recipient != address(0), "Invalid recipient address");
        require(balanceOf[msg.sender] >= amount, "Not enough balance for the transaction");

        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;

        emit Transfer(msg.sender, recipient, amount);
    }

    
}
