import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:newtodo/RegisterScreen.dart';
import 'package:newtodo/todolistpage.dart';

import 'constwidget.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;

  late String userEmail;
  late String userPassword;

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
                "Login",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold, fontSize: 35),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  onChanged: (value) {
                    userEmail = value;
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
                  onChanged: (value) {
                    userPassword = value;
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () async {
                    // print(email);
                    // print(password);

                   try{
                     final user =await _auth.signInWithEmailAndPassword(
                         email: userEmail, password: userPassword);
                     if(user != null){
                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>TodoListPage()));
                     }
                   }catch(e){
                      CircularProgressIndicator();
                   }
                  },
                  child: Text('Login', style: TextStyle(color: Colors.white)),
                ),
              ),
              TextButton(
                // style: ButtonStyle(
                //     backgroundColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: ()  {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);


                },
                child: Text('Register', style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        )
    );
  }
}



