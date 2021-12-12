// ignore_for_file: prefer_const_constructors, unnecessary_this, prefer_const_constructors_in_immutables

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:ev_otomasyon_sistemleri/drawer.dart';
import 'package:ev_otomasyon_sistemleri/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DashboardGas extends StatefulWidget {
  DashboardGas({Key? key}) : super(key: key);

  @override
  _DashboardGasState createState() => _DashboardGasState();
}

class _DashboardGasState extends State<DashboardGas> {
  bool isLoading = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _database = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPanel(),
      appBar: AppBar(
        title: Text('Gaz'),
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
            stream: _database.child('gaz').onValue,
            builder: (context, snapshot) {
              if (snapshot.data!.snapshot.value == 1) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    createLogo('gas_open'),
                    Text(
                      'Gaz Var',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              } else if (snapshot.data!.snapshot.value == 0) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    createLogo('gas_close'),
                    Text(
                      'Gaz Yok',
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

  createLogo(String gazDurumu) {
    return CircularProfileAvatar(
      '',
      child: Image.asset(
        'assets/images/$gazDurumu.png',
        scale: 1.25,
        
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
