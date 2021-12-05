// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:ev_otomasyon_sistemleri/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'drawer.dart';

class DashboardLight extends StatefulWidget {
  DashboardLight({Key? key}) : super(key: key);

  @override
  _DashboardLightState createState() => _DashboardLightState();
}

class _DashboardLightState extends State<DashboardLight> {
  bool isLoading = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPanel(),
      appBar: AppBar(
        title: Text('Işık'),
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
            stream: _database.child('isik').onValue,
            builder: (context, snapshot) {
              if (snapshot.data!.snapshot.value == 1) {
                return createLogo('light');
              } else if (snapshot.data!.snapshot.value == 0) {
                return createLogo('dark');
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

  createLogo(String isikDurumu) {
    return CircularProfileAvatar(
      '',
      child: Image.asset('assets/images/$isikDurumu.jpg'),
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