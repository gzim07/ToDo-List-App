// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:to_do_app/helpers/objectbox_interface.dart';
import 'package:to_do_app/screens/home_screen.dart';

late ObjectBox objectBox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'To Do App',
        debugShowCheckedModeBanner: false,
        home: const HomeScreen());
  }
}
