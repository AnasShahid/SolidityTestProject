// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

contract SendMoneyExample{
    uint public balanceReceived;
    address private owner;
    bool private paused;

    constructor(){
        owner = msg.sender;
    }

    function receiveMoney() public payable{
        balanceReceived += msg.value;
    }

    function getBalance() public view returns (uint){
        return address(this).balance;
    }

    function setPaused(bool _paused) public {
        require(owner == msg.sender,"You are not the owner of the contract");
        paused = _paused;
    }

    function withdrawMoneyToAddress(address payable _to) public {
        require(owner == msg.sender,"You are not the owner of the contract");
        require(!paused,"Contract is paused");
        _to.transfer(getBalance());
    }
    function destroyConract(address payable to) public {
        require(owner == msg.sender,"You are not the owner of the contract");
        selfdestruct(to);
    }

}