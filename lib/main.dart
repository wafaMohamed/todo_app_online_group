import 'package:flutter/material.dart';
import 'package:note_app_online/pages/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(),
      home: SplashScreen(),
      // home: TodoListScreen(),
    );
  }
}
