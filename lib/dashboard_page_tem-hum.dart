// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, prefer_final_fields, unnecessary_new, non_constant_identifier_names, sized_box_for_whitespace, unnecessary_this, use_key_in_widget_constructors, prefer_typing_uninitialized_variables,file_names, prefer_const_literals_to_create_immutables

import 'package:ev_otomasyon_sistemleri/circular_slider.dart';
import 'package:advance_notification/advance_notification.dart';
import 'package:ev_otomasyon_sistemleri/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'main.dart';

class DashboardTemperatureHumidity extends StatefulWidget {
  static var hum;
  static var temp;
  static var klima;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardTemperatureHumidity>
    with TickerProviderStateMixin {
  bool isLoading = false;

  int switchInitialIndex = 1;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  final _database = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    _readTemperature();
    _readHumidity();
    readKlimaValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPanel(),
      appBar: AppBar(
        title: Text('Isı - Nem'),
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
                  CarouselSlider(
                    items: [
                      CircularSlider.createSlider(
                          trackColor: "#ef6c00",
                          progressBarColor: "#ffb74d",
                          gostergeAdiRengi: "#000000",
                          degerRengi: "#4300fa",
                          deger: DashboardTemperatureHumidity.temp,
                          degerTipi: ' °C',
                          gostergeAdi: 'Sıcaklık',
                          initialValue:
                              DashboardTemperatureHumidity.temp.toDouble(),
                          minValue: 0,
                          maxValue: 60),
                      CircularSlider.createSlider(
                          trackColor: "#0004db",
                          progressBarColor: '#08fa00',
                          gostergeAdi: 'Nem',
                          gostergeAdiRengi: '#000000',
                          deger: DashboardTemperatureHumidity.hum,
                          degerTipi: ' %',
                          degerRengi: '#ff1a1a',
                          initialValue:
                              DashboardTemperatureHumidity.hum.toDouble(),
                          minValue: 0,
                          maxValue: 100),
                    ],
                    options: CarouselOptions(),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Klima',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
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
                              _database.child('klima').set(0);
                              createKlimaNotification(
                                  'Klima Kapatılıyor...', Colors.red);
                            } else if (index == 1) {
                              switchInitialIndex = 1;
                              _database.child('klima').set(2);
                              createKlimaNotification(
                                  'Klima Otomatik...', Colors.blue);
                            } else if (index == 2) {
                              switchInitialIndex = 2;
                              _database.child('klima').set(1);
                              createKlimaNotification(
                                  'Klima Açılıyor...', Colors.green);
                            }
                          },
                        ),
                      ],
                    ),
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

  createKlimaNotification(String message, Color renk) {
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

  readKlimaValue() {
    return _database.child('klima').onValue.listen((event) {
      DashboardTemperatureHumidity.klima = event.snapshot.value;
      setState(() {});
    });
  }

  _readTemperature() {
    return _database.child('sicaklik').onValue.listen((event) {
      DashboardTemperatureHumidity.temp = event.snapshot.value;
      setState(() {
        if (DashboardTemperatureHumidity.temp > 40) {
          highTemperatureAlert();
        }
      });
      isLoading = true;
    });
  }

  _readHumidity() {
    return _database.child('nem').onValue.listen((event) {
      DashboardTemperatureHumidity.hum = event.snapshot.value;
      setState(() {});
      isLoading = true;
    });
  }

  highTemperatureAlert() {
    Alert(
        context: context,
        image: Image.asset('assets/images/high-temperature.png'),
        title: 'YÜKSEK SICAKLIK',
        desc: 'Oda sıcaklığı çok yüksek!',
        style: AlertStyle(
          isCloseButton: false,
          isOverlayTapDismiss: false,
        ),
        buttons: [
          DialogButton(
              child: Text(
                'Tamam',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context)),
          DialogButton(
              color: Colors.red,
              child: Text(
                'Klimayı Aç',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                _database.child('klima').set(1);
              })
        ]).show();
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
