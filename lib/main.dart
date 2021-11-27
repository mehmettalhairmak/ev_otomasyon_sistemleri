// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ev Otomasyon Sistemi',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
