// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ev_otomasyon_sistemleri/dashboard_page_humidity.dart';
import 'package:ev_otomasyon_sistemleri/dashboard_page_temperature.dart';
import 'package:flutter/material.dart';

class DrawerPanel extends StatelessWidget {
  const DrawerPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menü',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.local_fire_department),
            title: Text('Isı Sensörü'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => DashboardTemperature()),
                  (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.water),
            title: Text('Nem Sensörü'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => DashboardHumidity()),
                  (Route<dynamic> route) => false);
            },
          )
        ],
      ),
    );
  }
}
