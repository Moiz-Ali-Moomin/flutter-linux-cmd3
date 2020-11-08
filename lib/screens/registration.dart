import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  var authc = FirebaseAuth.instance;

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Registration'),
      ),
      body: Center(
        child: Container(
          width: 353,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Registration Page',
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 53.0),
              Column(children: <Widget>[
                TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
              ]),
              SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                    labelText: 'PASSWORD ',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
                obscureText: true,
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.green,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          var user = await authc.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          print(email);
                          print(password);
                          print(user);

                          if (user.additionalUserInfo.isNewUser == true) {
                            print("Registered new user");
                            Navigator.pushNamed(context, "terminal");
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Center(
                        child: Text(
                          'SIGNUP',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  )),
              SizedBox(height: 20.0),
              Container(
                height: 40.0,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1.0),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Center(
                      child: Text('Go Back',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat')),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
