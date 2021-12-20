// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ev_otomasyon_sistemleri/dashboard_page_gas.dart';
import 'package:ev_otomasyon_sistemleri/dashboard_page_light.dart';
import 'package:ev_otomasyon_sistemleri/dashboard_page_movement.dart';
import 'package:ev_otomasyon_sistemleri/dashboard_page_tem-hum.dart';
import 'package:ev_otomasyon_sistemleri/main_page.dart';
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
            decoration: BoxDecoration(color: Colors.teal),
            child: Text(
              'Menü',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Ana Menü'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MainPage()),
                  (Route<dynamic> route) => false);
            },
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
          ListTile(
            leading: Icon(Icons.light),
            title: Text('Işık Sensörü'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => DashboardLight()),
                  (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.cloud),
            title: Text('Gaz Sensörü'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => DashboardGas()),
                  (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.accessibility_new),
            title: Text('Hareket Sensörü'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => DashboardMovement()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
