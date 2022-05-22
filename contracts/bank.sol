// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Bank {
    address public bankOwner;
    string public bankName;
    mapping(address => uint256) public accountBalance;

    constructor (){
        bankOwner = msg.sender;
    }

    function depositMoney () public payable {
        require(msg.value > 0 , "You have to deposit a specific amount");
        accountBalance[msg.sender] += msg.value;

    }

    function setBankName (string memory _name) external {
        require(msg.sender == bankOwner, "Only the bank owner can change the bank name");
        bankName = _name;
    }

    function withdrawMoney ( address payable _to, uint256 _total) public {
        require(_total <= accountBalance[_to], "Insufficient balance");
        accountBalance[_to] -= _total;
        _to.transfer(_total);
    }

    function getCustomerBalance () external view returns (uint256) {
        return accountBalance[msg.sender];
    }

    function getBankBalance () public view returns (uint256){
        require(msg.sender == bankOwner, "Only bank owner can see all the balances");
        return address(this).balance;
    }
}