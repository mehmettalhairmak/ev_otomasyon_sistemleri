// ignore_for_file: unused_import, unnecessary_null_comparison, prefer_const_constructors_in_immutables, must_call_super, prefer_final_fields, prefer_const_constructors, file_names, duplicate_import, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dashboard_page_temperature.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key, final String? title}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>['email'],
  );

  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleFirebase();
      }
    });
    _googleSignIn.signInSilently();
  }

  void _handleFirebase() async {
    GoogleSignInAuthentication googleAuth = await _currentUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    final UserCredential firebaseUser =
        await firebaseAuth.signInWithCredential(credential);

    if (firebaseUser != null) {
      print('Login');

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashboardTemperature()));
    }
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giriş Ekranı'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _handleSignIn,
          child: Text('Giriş Yap'),
        ),
      ),
    );
  }
}
