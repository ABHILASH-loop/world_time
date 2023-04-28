import 'package:flutter/material.dart';
import 'package:world_time/screens/home.dart';
import 'package:world_time/screens/loading.dart';
import 'package:world_time/screens/select_country.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => Loading(),
      "/home":(context) => Home(),
      "/selectCountry":(context) => SelectCountry()
    },
  ));
}