import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Terminal extends StatefulWidget {
  @override
  _TerminalState createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
  var msgtextcontroller = TextEditingController();

  var fs = FirebaseFirestore.instance;
  var authc = FirebaseAuth.instance;

  String cmd, output;
  String getans;
  String newvalue;

  mydata() async {
    var url = 'http://fc011477e049.ngrok.io/cgi-bin/cmd2.py?x=$cmd';
    var r = await http.get(url);
    var data = r.body;
    output = data;
  }

  getansdisplay() async {
    await fs.collection("commands").doc(newvalue).get().then((value) {
      var data = value.data;
      print((data()['output']));
      setState(() {
        getans = data()['output'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var signInUser = authc.currentUser.email;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Linux Terminal'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
                child: Center(
                    child: Text("Linux Terminal",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold))),
              ),
              SizedBox(height: 50),
              Container(
                width: deviceWidth * 0.70,
                child: TextFormField(
                  controller: msgtextcontroller,
                  decoration: InputDecoration(
                      fillColor: Colors.black,
                      labelText: 'Enter command',
                      border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ))),
                  onChanged: (value) {
                    cmd = value;
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: deviceWidth * 0.13,
                width: deviceWidth * 0.50,
                child: RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.green,
                        width: 1,
                        style: BorderStyle.solid),
                  ),
                  child: Text('Execute Command'),
                  onPressed: () async {
                    msgtextcontroller.clear();
                    await mydata();
                    await fs.collection("commands").add({
                      "cmd": cmd,
                      "output": output,
                      "sender": signInUser,
                    }).then((value) {
                      print(value.id);
                      print(cmd);
                      print(output);
                      newvalue = value.id;
                      getansdisplay();
                    });
                    print(signInUser);
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 500,
                    width: 500,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(getans ?? "Output..."),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
