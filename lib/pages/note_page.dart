// import 'package:flutter/material.dart';
//
// import '../database/local/database_helper.dart';
// import '../model/note_model.dart';
//
// class TodoListScreen extends StatefulWidget {
//   @override
//   _TodoListScreenState createState() => _TodoListScreenState();
// }
//
// class _TodoListScreenState extends State<TodoListScreen> {
//   final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//
//   List<Todo> _todoList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _refreshTodoList();
//   }
//
//   Future<void> _refreshTodoList() async {
//     List<Todo> todoList = await _databaseHelper.getTodoList();
//     setState(() {
//       _todoList = todoList;
//     });
//   }
//
//   Future<void> _addTodo() async {
//     String name = _nameController.text;
//     String description = _descriptionController.text;
//     if (name.isNotEmpty && description.isNotEmpty) {
//       await _databaseHelper.insertData({
//         'name': name,
//         'description': description,
//       });
//       _nameController.clear();
//       _descriptionController.clear();
//       _refreshTodoList();
//       _showSnackBar('Todo added', Colors.green);
//     }
//   }
//
//   Future<void> _updateTodo(Todo todo) async {
//     String name = _nameController.text;
//     String description = _descriptionController.text;
//     if (name.isNotEmpty && description.isNotEmpty) {
//       await _databaseHelper.updateData({
//         'id': todo.id,
//         'name': name,
//         'description': description,
//       });
//       _nameController.clear();
//       _descriptionController.clear();
//       _refreshTodoList();
//       _showSnackBar('Todo updated', Colors.purpleAccent);
//     }
//   }
//
//   Future<void> _deleteTodo(int id) async {
//     await _databaseHelper.deleteData(id);
//     _refreshTodoList();
//     _showSnackBar('Todo deleted', Colors.red);
//   }
//
//   void _showSnackBar(String message, Color color) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: const Duration(seconds: 2),
//         backgroundColor: color,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Todo List'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: ListView.builder(
//               itemCount: _todoList.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_todoList[index].name),
//                   subtitle: Text(_todoList[index].description),
//                   onTap: () {
//                     _nameController.text = _todoList[index].name;
//                     _descriptionController.text = _todoList[index].description;
//                   },
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () {
//                       _deleteTodo(_todoList[index].id!);
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 TextField(
//                   controller: _nameController,
//                   decoration: InputDecoration(labelText: 'Name'),
//                 ),
//                 TextField(
//                   controller: _descriptionController,
//                   decoration: InputDecoration(labelText: 'Description'),
//                 ),
//                 ElevatedButton(
//                   onPressed: _addTodo,
//                   child: Text('Add Todo'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_todoList.isNotEmpty) {
//                       _updateTodo(_todoList[0]);
//                     }
//                   },
//                   child: Text('Update Todo'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
