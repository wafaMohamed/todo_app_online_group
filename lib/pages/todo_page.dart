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
      backgroundColor: Colors.pink[100]!,
      appBar: AppBar(
        backgroundColor: Colors.pink[100]!,
        title: Text('Todo List'),
      ),
      body: _todoList.isEmpty
          ? Center(
              child: Text(
                'No todos available',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                final todo = _todoList[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Text(
                      todo.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${todo.description}\n${_formatDateTime(todo.dateTime)}',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    onTap: () {
                      _navigateToTodoDetailScreen(todo: todo);
                    },
                    onLongPress: () {
                      _deleteTodoDialog(context, todo);
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

  Future<void> _deleteTodoDialog(BuildContext context, Todo todo) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Todo'),
          content: Text('Are you sure you want to delete this todo?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteTodo(todo);
                Navigator.of(context).pop();
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
