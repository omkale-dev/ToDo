import 'package:ToDo/models/taskData.dart';
import 'package:flutter/material.dart';
import 'screens/taskScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
          create: (context) => TaskData(),
          child: Consumer<TaskData>(
              builder: (context, value, child) => TaskScreen(
                    taskData: value,
                  ))),
    );
  }
}
