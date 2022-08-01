// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.13;


contract Calulator {
 uint result;

 function add(uint a, uint b) public {
     result = a + b;
 }

 function sub(uint a, uint b) public {
     result = a - b;
 }

 function mul(uint a, uint b) public {
     result = a * b;
 }

 function div(uint a, uint b) public {
     require(b > 0, "The second parameter should be larger than 0");
     result = a / b;
 }

 function getResult() public view returns(uint){
     return result;
 }
}
