// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:objectbox/objectbox.dart';
import 'package:to_do_app/main.dart';
import 'package:to_do_app/models/task_model.dart';

class TaskEditorScreen extends StatefulWidget {
  const TaskEditorScreen({Key? key}) : super(key: key);

  @override
  State<TaskEditorScreen> createState() => _TaskEditorScreenState();
}

class _TaskEditorScreenState extends State<TaskEditorScreen> {
  Box<TodoEntity> todoBox = objectBox.store.box<TodoEntity>();
  TextEditingController _taskTitleController = TextEditingController();
  TextEditingController _taskDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        elevation: 0.0,
        title: Text("Create a New Task"),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task Title",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _taskTitleController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  hintStyle: TextStyle(color: Colors.white12),
                  hintText: "Type your Task Title eg : Buy some Milk",
                  filled: true,
                  fillColor: Colors.black12,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Task Description",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _taskDescController,
                minLines: 5,
                maxLines: 10,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  hintStyle: TextStyle(color: Colors.white12),
                  hintText: "Type your Task Desciption",
                  filled: true,
                  fillColor: Colors.black12,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: () {
                      String taskTitle = _taskTitleController.text;
                      String taskDesk = _taskDescController.text;
                      TodoEntity model = TodoEntity(
                          task_title: taskTitle,
                          task_desciption: taskDesk,
                          task_done: false,
                          creation_date: DateTime.now());

                      todoBox.put(model);
                      Navigator.pop(context);
                    },
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 40,
                      child: Text('Save Task'),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
