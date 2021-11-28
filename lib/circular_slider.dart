// ignore_for_file: prefer_const_constructors

import 'package:ev_otomasyon_sistemleri/dashboard_page_humidity.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'dashboard_page_temperature.dart';
import 'hex_color.dart';

class CircularSlider {
  static createSlider({
    required String trackColor,
    required String progressBarColor,
    required String gostergeAdi,
    required String gostergeAdiRengi,
    required var deger,
    required String degerTipi,
    required String degerRengi,
    required double initialValue,
  }) {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        customWidths: CustomSliderWidths(
          trackWidth: 4,
          progressBarWidth: 15,
        ),
        customColors: CustomSliderColors(
          trackColor: HexColor(trackColor),
          progressBarColor: HexColor(progressBarColor),
        ),
        infoProperties: InfoProperties(
          bottomLabelStyle: TextStyle(
              color: HexColor(gostergeAdiRengi),
              fontSize: 20,
              fontWeight: FontWeight.w600),
          bottomLabelText: gostergeAdi,
          mainLabelStyle: TextStyle(
              color: HexColor(degerRengi),
              fontSize: 30.0,
              fontWeight: FontWeight.w600),
          modifier: (var value) {
            return deger.toString() + "$degerTipi";
          },
        ),
        startAngle: 90,
        angleRange: 360,
        size: 200.0,
        animationEnabled: true,
      ),
      min: 0,
      max: 100,
      initialValue: initialValue,
    );
  }
}
