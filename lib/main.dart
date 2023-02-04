import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newtodo/RegisterScreen.dart';
import 'package:newtodo/constwidget.dart';
import 'package:newtodo/todolistpage.dart';
import 'package:newtodo/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  FirebaseFirestore.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});




  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
