// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:advance_notification/advance_notification.dart';
import 'package:ev_otomasyon_sistemleri/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'drawer.dart';

class DashboardLight extends StatefulWidget {
  DashboardLight({Key? key}) : super(key: key);

  @override
  _DashboardLightState createState() => _DashboardLightState();
}

class _DashboardLightState extends State<DashboardLight> {
  bool isLoading = false;
  int switchInitialIndex = 1;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StreamBuilder<Event>(
                stream: _database.child('isik').onValue,
                builder: (context, snapshot) {
                  if (snapshot.data!.snapshot.value == 1) {
                    return createLogo('light.jpg');
                  } else if (snapshot.data!.snapshot.value == 0) {
                    return createLogo('dark.jpg');
                  } else if (snapshot.data!.snapshot.value == 2) {
                    return createLogo('autolight.png');
                  } else {
                    return Text(
                      'Yükleniyor...',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    );
                  }
                }),
            ToggleSwitch(
              minWidth: 90.0,
              minHeight: 50.0,
              fontSize: 16.0,
              initialLabelIndex: switchInitialIndex,
              activeBgColors: [
                [Colors.red],
                [Colors.blue],
                [Colors.green],
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.grey[900],
              totalSwitches: 3,
              labels: ['Kapalı', 'Oto', 'Açık'],
              onToggle: (index) {
                if (index == 0) {
                  switchInitialIndex = 0;
                  _database.child('isik').set(0);
                  createLightNotification('Işıklar Kapatılıyor...', Colors.red);
                } else if (index == 1) {
                  switchInitialIndex = 1;
                  _database.child('isik').set(2);
                  createLightNotification('Işıklar Otomatik...', Colors.blue);
                } else if (index == 2) {
                  switchInitialIndex = 2;
                  _database.child('isik').set(1);
                  createLightNotification('Işıklar Açılıyor...', Colors.green);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  createLogo(String isikDurumu) {
    return CircularProfileAvatar(
      '',
      child: Image.asset('assets/images/$isikDurumu'),
      borderColor: Colors.transparent,
      borderWidth: 5,
      elevation: 2,
      radius: 120,
    );
  }

  createLightNotification(String message, Color renk) {
    AdvanceSnackBar(
      message: message,
      mode: 'ADVANCE',
      duration: Duration(seconds: 1),
      textSize: 22,
      mHeight: 60,
      isIcon: true,
      bgColor: renk,
    ).show(context);
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
