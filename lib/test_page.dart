// ignore_for_file: prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ReadExamples extends StatefulWidget {
  ReadExamples({Key? key}) : super(key: key);

  @override
  _ReadExamplesState createState() => _ReadExamplesState();
}

class _ReadExamplesState extends State<ReadExamples> {
  String _displayText = 'Result go here ';
  final _database = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    _activeListeners();
  }

  _activeListeners() {
    _database.child("hareket").onValue.listen((event) {
      final String description = event.snapshot.value;
      setState(() {
        _displayText = 'Todays special : $description';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Examples'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [Text(_displayText)],
          ),
        ),
      ),
    );
  }
}
