import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newtodo/LoginScreen.dart';
import 'package:newtodo/constwidget.dart';

class TodoListPage extends StatefulWidget {
  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _auth = FirebaseAuth.instance;
  late final User Service;

  late User loggedIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedIn = user;
        print(loggedIn.email);
      }
    } catch (e) {
      print(e);
    }
  }

  final TextEditingController _controller = TextEditingController();
  //final TextEditingController _controllernew = TextEditingController();

  addButton() async {
    final logintwo = _auth.currentUser;
    await FirebaseFirestore.instance.collection('task').add({
      "text": _controller.text,
      "email": logintwo?.email,
      "uid": _auth.currentUser!.uid.toString(),
    });
  }

  late bool ifalls = false;
  // get result {
  //   return ifalls;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ifalls ? Colors.black : Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  ifalls = !ifalls;
                });
              },
              icon: Icon(ifalls ? iconbright : iconDart)),
          IconButton(
              onPressed: () {
                _auth.signOut().then((value) => Navigator.of(context)
                    .pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => RegisterScreen()),
                        (route) => false));
              },
              icon: Icon(Icons.settings_backup_restore_outlined,
                  color: ifalls ? Colors.white : Colors.white))
        ],
        backgroundColor: ifalls ? Colors.black : Colors.indigo,
        title: Text('Todo List'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'write your task...',

                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo)),
              onPressed: () {

                addButton();
                _controller.clear();
              },
              child: Text(
                'ADD',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('task')
                    .where("uid", isEqualTo: _auth.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    return ListView(
                      children: snapshot.data!.docs.map((documents) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                                title: Text(
                                  documents['text'],
                                  style: TextStyle(color: Colors.white),
                                ),
                                // subtitle: Text(_auth.currentUser!.email.toString()),
                                trailing: IconButton(
                                  onPressed: () {
                                    onDelete(documents.id);
                                  },
                                  icon: Icon(Icons.delete, color: Colors.white),
                                )),
                          ),
                        );
                      }).toList(),
                    );
                  }
                }),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        splashColor: Colors.white,
        hoverColor: Colors.blue,
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )),
            context: context,
            builder: (context) {
              return Container(
                height: 250,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Task',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                          controller: _controller,
                          decoration: new InputDecoration(
                            hintText: 'write your task...',
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(purplestyle)),
                        onPressed: () {
                          addButton();
                          _controller.clear();
                        },
                        child: Text(
                          'ADD',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void onDelete(String id) {
    FirebaseFirestore.instance.collection('task').doc(id).delete();
  }
}
