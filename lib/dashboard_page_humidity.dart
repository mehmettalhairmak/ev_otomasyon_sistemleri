// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, prefer_final_fields, unnecessary_new, non_constant_identifier_names, sized_box_for_whitespace, unnecessary_this, use_key_in_widget_constructors

import 'package:ev_otomasyon_sistemleri/circular_slider.dart';
import 'package:ev_otomasyon_sistemleri/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'main.dart';

class DashboardHumidity extends StatefulWidget {
  static var hum;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardHumidity>
    with TickerProviderStateMixin {
  bool isLoading = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final _database = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    _readHumidity();
  }

  _readHumidity() {
    return _database.child('nem').onValue.listen((event) {
      DashboardHumidity.hum = event.snapshot.value;
      setState(() {});
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPanel(),
      appBar: AppBar(
        title: Text('Gösterge Paneli - Nem'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: handleLoginOutPopup,
          ),
        ],
      ),
      body: Center(
        child: isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircularSlider.createSlider(
                    trackColor: "#0004db",
                    progressBarColor: '#08fa00',
                    gostergeAdi: 'Nem',
                    gostergeAdiRengi: '#000000',
                    deger: DashboardHumidity.hum,
                    degerTipi: ' %',
                    degerRengi: '#ff1a1a',
                    initialValue: DashboardHumidity.hum.toDouble(),
                  )
                ],
              )
            : Text(
                'Yükleniyor...',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
      ),
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

  Future<Null> handleSignOut() async {
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
