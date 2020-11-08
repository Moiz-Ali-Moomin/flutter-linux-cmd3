import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttert3/screens/terminal.dart';
import 'package:fluttert3/screens/login.dart';
import 'package:fluttert3/screens/registration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "login",
      routes: {
        "reg": (context) => Registration(),
        "login": (context) => MyLogin(),
        "terminal": (context) => Terminal(),
      },
    ),
  );
}
