import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final Function toggleDone;
  final String text;
  final bool isChecked;
  final Function delete;

  TaskItem({this.text,this.isChecked,this.toggleDone,this.delete});
  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        onLongPress: delete,
        title: Text(
          text,
          style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Checkbox(
          onChanged:toggleDone,
          value: isChecked,
          
        ),
      ),
    );
  }
}


// text: taskData.taskList[i].name,
//                 toggleDone: taskData.taskList[i].toggleIsDone,