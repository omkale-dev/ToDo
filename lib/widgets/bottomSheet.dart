import 'package:ToDo/models/taskData.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class AddTaskBottomSheet extends StatelessWidget {
  var task;
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    // TaskData taskData = Provider.of<TaskData>(context,listen: false);
    return SingleChildScrollView(
      child: Container(
        color: Color(0xff767676),
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Add Task',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  TextField(
                    autofocus: true,
                    controller: controller,
                    onChanged: (val) {
                      task=val;
                    },
                  ),
                  // Consumer<TaskData>(
                  //     builder: (context, taskData, child) =>
                  FlatButton(
                    onPressed: () {
                      // taskData.addTask(controller.value.toString());
                      Navigator.pop(context, task);
                      controller.clear();
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.lightBlueAccent,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
