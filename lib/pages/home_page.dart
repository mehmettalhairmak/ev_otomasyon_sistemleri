// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables

import 'package:ev_otomasyon_sistemleri/widgets/drawer.dart';
import 'package:ev_otomasyon_sistemleri/main.dart';
import 'package:ev_otomasyon_sistemleri/widgets/panel_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String title =
      "Ev Otomasyon Sistemleri bir akıllı ev projesidir. Bu Ev Otomasyonu Sistemleri projemiz sayesinde elimizdeki telefon üzerinden evimizin o anki durumunu öğrenebiliriz.\nEvinizdeki ısı ve nem oranını anlık olarak takip edebilirsiniz. Örneğin evden uzaktasınız ve klimanız açık kalmış, Ev Otomasyon Sistemleri uygulamasıyla klimayı kapatabilirsiniz. Başka bir örnek ise evden çıktınız fakat ışıkların veya tüpün açık olup olmadığını hatırlamıyorsunuz, Ev Otomasyon Sistemleri uygulaması sayesinde ışıklarınızın ve havada tehlikeli gaz bulunup bulunmadığını görebiliyorsunuz ve uzaktan ışıklarınızı kontrol edebiliyorsunuz. Anlık olarak yüksek sıcaklık & tehlikeli gaz bulunan hava tespit edildiğinde telefonunuza anında bildirim geliyor.";

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      //Bildirim.bildirimInit(context);
    }

    return Scaffold(
      drawer: DrawerPanel(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ev Otomasyon Sistemleri'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: handleLoginOutPopup,
          ),
        ],
      ),
      body: SlidingUpPanel(
        body: homePage(),
        minHeight: 40,
        panelBuilder: (controller) => PanelWidget(controller: controller),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  homePage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/images/meb_logo.png",
                width: 100,
                height: 100,
              ),
              Image.asset(
                "assets/images/tubitak_logo.png",
                width: 100,
                height: 100,
              ),
              Image.asset(
                "assets/images/okul_logo.png",
                width: 100,
                height: 100,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            children: [
              Text(
                'Deniz Yıldızları Mesleki ve Teknik Anadolu Lisesi',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'TÜBİTAK 4006',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 14),
                  ),
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
    this.setState(() {});

    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();

    this.setState(() {});

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyApp()),
        (Route<dynamic> route) => false);
  }
}
