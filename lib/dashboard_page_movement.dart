// ignore_for_file: prefer_const_constructors, unnecessary_this, prefer_const_constructors_in_immutables

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:ev_otomasyon_sistemleri/drawer.dart';
import 'package:ev_otomasyon_sistemleri/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DashboardMovement extends StatefulWidget {
  DashboardMovement({Key? key}) : super(key: key);

  @override
  _DashboardMovementState createState() => _DashboardMovementState();
}

class _DashboardMovementState extends State<DashboardMovement> {
  bool isLoading = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _database = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPanel(),
      appBar: AppBar(
        title: Text('Hareket'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: handleLoginOutPopup,
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder<Event>(
            stream: _database.child('hareket').onValue,
            builder: (context, snapshot) {
              if (snapshot.data!.snapshot.value == 1) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    createMovementLogo(),
                    Text(
                      'Hareket Var',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              } else if (snapshot.data!.snapshot.value == 0) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    createStayLogo(),
                    Text(
                      'Hareket Yok',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              } else {
                return Text(
                  'Yükleniyor...',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                );
              }
            }),
      ),
    );
  }

  createMovementLogo() {
    return CircularProfileAvatar(
      '',
      child: Image.asset(
        'assets/images/movement.gif',
        fit: BoxFit.cover,
      ),
      borderColor: Colors.transparent,
      borderWidth: 5,
      elevation: 2,
      radius: 120,
    );
  }

  createStayLogo() {
    return CircularProfileAvatar(
      '',
      child: Image.asset(
        'assets/images/stay.png',
        scale: 1.5,
      ),
      borderColor: Colors.transparent,
      borderWidth: 5,
      elevation: 2,
      radius: 120,
    );
  }

  handleLoginOutPopup() {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Çıkış Yap",
      desc: "Çıkış yapmak mı istiyorsun?",
      buttons: [
        DialogButton(
          child: Text(
            "Hayır",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.teal,
        ),
        DialogButton(
          child: Text(
            "Evet",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: handleSignOut,
          color: Colors.teal,
        )
      ],
    ).show();
  }

  Future handleSignOut() async {
    this.setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();

    this.setState(() {
      isLoading = false;
    });

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyApp()),
        (Route<dynamic> route) => false);
  }
}
