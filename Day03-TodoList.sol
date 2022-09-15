// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/**
 * for loop
 * struct 
 * mapping
 * Array - delete and Add
 */

contract TodoList {
    struct Todo {
        string text;
        bool done;
    }

    mapping(address => Todo[]) public todos;

    function addTodo(string memory _text) public {
        Todo memory todo = Todo(_text, false);
        todos[msg.sender].push(todo);
    }

    // add a function to remove a TODO item
    function remove(uint256 _index) public {
        todos[msg.sender][_index] = todos[msg.sender][
            todos[msg.sender].length - 1
        ];
        todos[msg.sender].pop();
    }

    // add a function to mark a todo item as completed
    function complete(uint256 _index) public {
        // mark the item at the given index as completed
        todos[msg.sender][_index].done = true;
    }

    // add a function to mark a todo item as uncompleted
    function uncomplete(uint256 _index) public {
        // mark the item at the given index as uncompleted
        todos[msg.sender][_index].done = false;
    }

    // add a function to get all todo items
    function getItems() public view returns (Todo[] memory) {
        // return the list of todo items
        return todos[msg.sender];
    }

    // add a function to get all completed todo items
    function getCompletedItems() public view returns (Todo[] memory) {
        // return the list of completed todo items

        Todo[] memory completedTodos = new Todo[](todos[msg.sender].length);
        for (uint256 i = 0; i < todos[msg.sender].length; i++) {
            if (todos[msg.sender][i].done == true) {
                completedTodos[i] = (todos[msg.sender][i]);
            }
        }
        return completedTodos;
    }

    // add a function to get all uncompleted todo items
    function getUncompletedItems() public view returns (Todo[] memory) {
        Todo[] memory completedTodos = new Todo[](todos[msg.sender].length);
        for (uint256 i = 0; i < todos[msg.sender].length; i++) {
            if (todos[msg.sender][i].done == false) {
                completedTodos[i] = (todos[msg.sender][i]);
            }
        }
        return completedTodos;
    }
}
