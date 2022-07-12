// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:objectbox/objectbox.dart';
import 'package:to_do_app/main.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/objectbox.g.dart';
import 'package:to_do_app/screens/task_editor_screen.dart';
import 'package:to_do_app/widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream<List<TodoEntity>>? fetchAllTask;

  Box<TodoEntity>? todoBox;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoBox = objectBox.store.box<TodoEntity>();
    print(todoBox!.count());
    setState(() {
      fetchAllTask = todoBox!
          .query()
          .watch(triggerImmediately: true)
          .map((event) => event.find());
    });
  }

  @override
  void dispose() {
    objectBox.store.close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Center(
          child: Container(
            padding: EdgeInsets.all(18),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "👋 Welcome Sir",
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Today\'s Tasks',
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TaskEditorScreen()));
                        },
                        icon: Icon(Icons.add),
                        label: Text(
                          "Add a new Task",
                        ))
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                StreamBuilder<List<TodoEntity>>(
                    stream: fetchAllTask!,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        if (snapshot.hasData)
                          return SingleChildScrollView(
                            child: Column(
                                children: snapshot.data!
                                    .map((e) => TaskWidget(e))
                                    .toList()),
                          );
                      }
                      return Center();
                    }),
              ],
            ),
          ),
        ));
  }
}
