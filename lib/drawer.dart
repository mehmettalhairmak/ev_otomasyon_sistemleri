// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ev_otomasyon_sistemleri/dashboard_page_tem-hum.dart';
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
            title: Text('Isı ve Nem Sensörü'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => DashboardTemperatureHumidity()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
