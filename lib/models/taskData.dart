import 'dart:collection';
import 'package:ToDo/models/task.dart';
import 'package:flutter/foundation.dart';
import 'databaseHelper.dart';

class TaskData extends ChangeNotifier {
  List _taskList = [];
  Future<void> fetchToTasklist() async {
    List<Map<dynamic, dynamic>> list =
        await DatabaseHelper.instance.fetchFromDatabase();
    list.forEach((element) {
      _taskList.add(Task(
          name: element['task'],
          isDone: element['isDone'] == 0 ? false : true));
    });
    notifyListeners();
  }

  void addTask(String name) {
    _taskList.add(Task(name: name));
    DatabaseHelper.instance.addItemToDatabase(name: name, isDone: false);
    notifyListeners();
  }

  void removeTask(Task task) {
    _taskList.remove(task);
    DatabaseHelper.instance.deleteFromDatabase(task: task.name);
    notifyListeners();
  }

  int get taskListLength {
    return _taskList.length;
  }

  List get taskList {
    return UnmodifiableListView(_taskList); //protects from direct access
  }

  Function toggleDone(Task task) {
    task.toggleIsDone();
    DatabaseHelper.instance
        .updateItemInDatabase(task: task.name, isDone: task.isDone);
    notifyListeners();
    return null;
  }
}
