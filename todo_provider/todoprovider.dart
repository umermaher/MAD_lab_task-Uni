import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Todo.dart';

class TodoProvider extends ChangeNotifier {
  List<ToDo> todos = [];

  List<ToDo> get todoList => todos;

  addTodo(ToDo todo) {
    todos.add(todo);
    notifyListeners();
  }

  removeTodo(int index) {
    todos.removeAt(index);
    notifyListeners();
  }

  toggleIsDone(int index) {
    todos[index].isDone = !todos[index].isDone;
    notifyListeners();
  }
}