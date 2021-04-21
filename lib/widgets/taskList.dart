import 'package:ToDo/widgets/taskItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ToDo/models/taskData.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TaskData taskData = Provider.of<TaskData>(context);
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView.builder(
            itemCount: taskData.taskListLength,
            itemBuilder: (c, i) {
              return TaskItem(
                text: taskData.taskList[i].name,
                toggleDone: (val) {
                  taskData.toggleDone(taskData.taskList[i]);
                },
                isChecked: taskData.taskList[i].isDone,
                delete: () => taskData.removeTask(taskData.taskList[i]),
              );
            },
          ),
        ),
      ),
    );
  }
}
