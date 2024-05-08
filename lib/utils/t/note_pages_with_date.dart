// import 'package:flutter/material.dart';
//
// import '../../model/note_model.dart';
// import '../database/local/database_helper.dart'; // Import your Todo model here
//
// class TodoListScreen extends StatefulWidget {
//   @override
//   _TodoListScreenState createState() => _TodoListScreenState();
// }
//
// class _TodoListScreenState extends State<TodoListScreen> {
//   late DatabaseHelper _databaseHelper;
//   late List<Todo> _todos;
//
//   @override
//   void initState() {
//     super.initState();
//     _databaseHelper = DatabaseHelper.instance;
//     _loadTodos();
//   }
//
//   Future<void> _loadTodos() async {
//     _todos = await _databaseHelper.getTodoList();
//     setState(() {}); // Refresh UI
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Todo List'),
//       ),
//       body: ListView.builder(
//         itemCount: _todos.length,
//         itemBuilder: (context, index) {
//           final todo = _todos[index];
//           return ListTile(
//             title: Text(todo.name),
//             subtitle: Text(todo.description),
//             trailing: IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: () {
//                 _deleteTodo(todo.id!);
//               },
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _navigateToTodoDetailScreen(context);
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
//
//   Future<void> _deleteTodo(int id) async {
//     await _databaseHelper.deleteTodo(id);
//     _loadTodos();
//   }
//
//   void _navigateToTodoDetailScreen(BuildContext context) {
//     Navigator.of(context)
//         .push(
//           MaterialPageRoute(
//             builder: (context) =>
//                 TodoDetailScreen(databaseHelper: _databaseHelper),
//           ),
//         )
//         .then((_) => _loadTodos());
//   }
// }
//
// class TodoDetailScreen extends StatefulWidget {
//   final DatabaseHelper databaseHelper;
//
//   TodoDetailScreen({required this.databaseHelper});
//
//   @override
//   _TodoDetailScreenState createState() => _TodoDetailScreenState();
// }
//
// class _TodoDetailScreenState extends State<TodoDetailScreen> {
//   late TextEditingController _nameController;
//   late TextEditingController _descriptionController;
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController();
//     _descriptionController = TextEditingController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Todo'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: _descriptionController,
//               decoration: InputDecoration(labelText: 'Description'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 _addTodo(context);
//               },
//               child: Text('Add'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _addTodo(BuildContext context) async {
//     final name = _nameController.text.trim();
//     final description = _descriptionController.text.trim();
//     if (name.isNotEmpty && description.isNotEmpty) {
//       final todo = Todo(
//         name: name,
//         description: description,
//         dateTime: DateTime.now(),
//       );
//       await widget.databaseHelper.insertTodo(todo);
//       Navigator.of(context).pop();
//     } else {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Error'),
//           content: Text('Please enter both name and description.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }
// }
