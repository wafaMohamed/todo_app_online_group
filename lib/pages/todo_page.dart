import 'package:flutter/material.dart';
import 'package:note_app_online/pages/todo_details_page.dart';

import '../database/local/database_helper.dart';
import '../model/note_model.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late List<Todo> _todoList = [];

  @override
  void initState() {
    super.initState();
    _refreshTodoList();
  }

  Future<void> _refreshTodoList() async {
    _todoList = await DatabaseHelper.instance.getTodoList();
    setState(() {});
  }

  void _navigateToTodoDetailScreen({Todo? todo}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TodoDetailScreen(todo: todo),
      ),
    );
    if (result == true) {
      _refreshTodoList();
    }
  }

  void _deleteTodo(Todo todo) async {
    await DatabaseHelper.instance.deleteTodo(todo.id!);
    _refreshTodoList();
    _showSnackBar('Todo deleted');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: _todoList.isEmpty
          ? Center(
              child: Text('No todos available'),
            )
          : ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                final todo = _todoList[index];
                return Dismissible(
                  key: Key(todo.id.toString()),
                  background: Container(color: Colors.red),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) => _deleteTodo(todo),
                  child: ListTile(
                    title: Text(todo.name),
                    subtitle: Text(
                      '${todo.description} - ${_formatDateTime(todo.dateTime)}',
                    ),
                    onTap: () {
                      _navigateToTodoDetailScreen(todo: todo);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToTodoDetailScreen();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}';
  }
}
