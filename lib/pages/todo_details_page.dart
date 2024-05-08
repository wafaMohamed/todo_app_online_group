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
    final todo = Todo(
      id: widget.todo?.id,
      name: name,
      description: description,
      dateTime: _selectedDate,
    );
    if (widget.todo == null) {
      await DatabaseHelper.instance.insertTodo(todo);
    } else {
      await DatabaseHelper.instance.updateTodo(todo);
    }
    Navigator.pop(context, true);
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 12),
            ListTile(
              title: Text('Date'),
              subtitle: Text(
                DateFormat('yyyy-MM-dd').format(_selectedDate),
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTodo,
              child: Text(widget.todo == null ? 'Add Todo' : 'Update Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
