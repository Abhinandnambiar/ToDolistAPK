import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newtodo/LoginScreen.dart';
import 'package:newtodo/constwidget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newtodo/todolistpage.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController userName = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.indigo,
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          containerLottie(),
          SizedBox(height: 10,),
          Text(
            "Register",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 35),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              onChanged: (value) {
                email = value;
              },
              // controller: _emailController,
              decoration: InputDecoration(
                  hintText: 'Enter email...',
                  hintStyle: TextStyle(color: Colors.white),

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: userName,
              // controller: _emailController,
              decoration: InputDecoration(
                  hintText: 'username...',
                  hintStyle: TextStyle(color: Colors.white),

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              onChanged: (value) {
                password = value;
              },
              //controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Password...',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ))),
            ),
          ),
          TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
            onPressed: () async {
              // print(email);
              // print(password);

              adduserData();

              try {
                final newUser = await _auth.createUserWithEmailAndPassword(
                    email: email, password: password);

                if (newUser != null) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => TodoListPage()));
                }
              } catch (e) {
                CircularProgressIndicator();
              }
            },
            child: Text('Register', style: TextStyle(color: Colors.white)),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>RegisterScreen()), (route) => false);

              },
              child: Text('Login',style: TextStyle(color: Colors.white),))
        ],
      ),
    ));
  }

  void adduserData() async {
    final loggedUser = _auth.currentUser;
    await FirebaseFirestore.instance.collection("user").add(
        {"username": userName.text, "id": _auth.currentUser!.uid.toString()});
  }


}
