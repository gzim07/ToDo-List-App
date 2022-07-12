// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:to_do_app/main.dart';
import 'package:to_do_app/models/task_model.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget(this.todoModel, {Key? key}) : super(key: key);
  final TodoEntity todoModel;
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  Box<TodoEntity> todoBox = objectBox.store.box<TodoEntity>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Checkbox(
              side: BorderSide(color: Colors.white),
              value: widget.todoModel.task_done,
              onChanged: (value) {
                widget.todoModel.task_done = value;
                todoBox.put(widget.todoModel);
              }),
          Expanded(
            child: Text(
              widget.todoModel.task_title!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              todoBox.remove(widget.todoModel.id);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
