import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/local/database_helper.dart';
import '../model/note_model.dart';

class TodoDetailScreen extends StatefulWidget {
  final Todo? todo;

  TodoDetailScreen({Key? key, this.todo}) : super(key: key);

  @override
  _TodoDetailScreenState createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.todo?.dateTime ?? DateTime.now();
    _nameController.text = widget.todo?.name ?? '';
    _descriptionController.text = widget.todo?.description ?? '';
  }

  void _saveTodo() async {
    final name = _nameController.text;
    final description = _descriptionController.text;

    if (name.isNotEmpty) {
      final todo = Todo(
        id: widget.todo?.id,
        name: name,
        description: description,
        dateTime: _selectedDate,
      );
      if (widget.todo == null) {
        await DatabaseHelper.instance.insertTodo(todo);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Todo added'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        await DatabaseHelper.instance.updateTodo(todo);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Todo updated'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Title cannot be empty'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo == null ? 'Add Todo' : 'Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter todo name',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: _descriptionController,
                  maxLines: null, // Allows multiline input
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter todo description',
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Date',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Text(
                    DateFormat('yyyy-MM-dd').format(_selectedDate),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTodo,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Text(
                  widget.todo == null ? 'Add Todo' : 'Update Todo',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
