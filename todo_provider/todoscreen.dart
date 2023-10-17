import 'package:chatscreenui/ui/todo/todoprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Todo.dart';



class TodoScreen extends StatefulWidget {

  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();

}

class _TodoScreenState extends State<TodoScreen> {

  @override
  Widget build(BuildContext context) {
    TodoProvider provider = context.watch<TodoProvider>();
    return Scaffold(
      appBar: AppBar(
          title: Text("Todo List Screen"),
          leading: BackButton(
            onPressed:()=> Navigator.of(context).pop(),
          )
      ),
      body: Center(
        child: ListView.builder(
            itemCount: context.watch<TodoProvider>().todos.length,
            itemBuilder: (context, index) {
              ToDo todo = provider.todos[index];
              return ListTile(
                leading: Checkbox(
                  value: todo.isDone,
                  onChanged: (value) {
                    provider.toggleIsDone(index);
                  },
                ),
                title: Text(todo.title),
                trailing: IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    provider.removeTodo(index);
                  },
                ),
              );
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.addTodo(
              ToDo(title: "Todo ${provider.todos.length}", isDone: false)
          );
        },
      ),
    );
  }

}