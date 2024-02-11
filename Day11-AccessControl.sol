// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
 
 import { AccessControl } from "@openzeppelin/contracts/access/AccessControl.sol";


 contract RoleBasedAccess is AccessControl {

    constructor(){
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }
    
    bytes32 public constant STUDENT_ROLE = keccak256("STUDENT_ROLE");
    bytes32 public constant PROFESSER_ROLE = keccak256("ROLE_ROLE");

    function submitTest() public view  returns (string memory){
        require(hasRole(STUDENT_ROLE, msg.sender),"You are not a student");
        return "Test Submited";
    }

    function gradeTest() public view returns (string memory){
        require(hasRole(PROFESSER_ROLE, msg.sender),"You are not a Professer");
        return "Test graded";
    }

 }
