// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract Todolist {
    struct Todo {
        string text;
        bool isDone;
    }

    Todo[] private todos;

    function addTodo(string memory _text) public {
        todos.push(Todo(_text, false));
    }

    // [1,2,3,4,5]
    // [1,5,3,4]
    function removeTodo(uint256 _index) public {
        todos[_index] = todos[todos.length - 1];
        todos.pop();
    }

    function getAllTodos() public view returns (Todo[] memory) {
        return todos;
    }

    function completeTodo(uint256 _index) public {
        todos[_index].isDone = true;
    }

    function unCompleteTodo(uint256 _index) public {
        todos[_index].isDone = false;
    }
}
