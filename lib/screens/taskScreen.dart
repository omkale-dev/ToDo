import 'package:ToDo/models/databaseHelper.dart';
import 'package:ToDo/models/taskData.dart';
import 'package:flutter/material.dart';
import 'package:ToDo/widgets/taskList.dart';
import 'package:ToDo/widgets/bottomSheet.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatefulWidget {
  final TaskData taskData;

  const TaskScreen({Key key, @required this.taskData}) : super(key: key);
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    super.initState();
    widget.taskData.fetchToTasklist();
  }

  @override
  void dispose() {
    super.dispose();
    DatabaseHelper.instance.closeDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.list,
                    color: Colors.lightBlueAccent,
                    size: 30,
                  ),
                  backgroundColor: Colors.white,
                  radius: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "toDO",
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Consumer<TaskData>(
                  builder: (context, taskData, child) => Text(
                    "${taskData.taskListLength} tasks",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Consumer<TaskData>(builder: (context, taskData, child) => TaskList()),
        ],
      ),
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: Consumer<TaskData>(
        builder: (context, taskData, child) => FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 30,
          ),
          backgroundColor: Colors.lightBlueAccent,
          onPressed: () async {
            var data = await showModalBottomSheet(
              context: context,
              builder: (context) => AddTaskBottomSheet(),
              isScrollControlled: true,
            );
            taskData.addTask(data);
          },
        ),
      ),
    );
  }
}
