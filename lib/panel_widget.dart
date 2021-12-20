// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  const PanelWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      controller: controller,
      children: [
        SizedBox(height: 17),
        buildDragHandle(),
        SizedBox(height: 24),
        buildAboutText(),
        SizedBox(height: 24),
      ],
    );
  }

  buildDragHandle() {
    return Center(
      child: Container(
        width: 150,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }

  buildAboutText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deniz Yıldızları Mesleki ve Teknik Anadolu Lisesi',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),
          Image.asset('assets/images/okul.jpg'),
          SizedBox(height: 40),
          Text(
            'Vizyon',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Text(
            'Mensubu olmaktan övünç duyulan, kaliteli insan gücü yetiştiren lider okul olmak.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 40),
          Text(
            'Misyon',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Text(
            'Ülkemizin geleceği için eğitim-öğretimde sürekli yenileşme ve gelişmeyi sağlayarak, toplumumuzun ve bölgemizin ihtiyaçlarına uygun, Milli Eğitimin genel ve özel amaçları ışığında kaliteli mesleki ve teknik eğitim hizmeti sunup, milli ve manevi değerlere bağlı, sanayimize ara eleman ve üst öğretime öğrenci yetiştirmek.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 40),
          Text(
            'İletişim',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Text(
            'Telefon : 0262 745 62 1516\n\nBelgegeçer : 0 262 745 62 19\n\nAdres : Nene Hatun Mah. Turgut Reis Cad. Bostan Sok. No25 41700 Darıca / KOCAELI',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
