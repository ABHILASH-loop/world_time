import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/selectCountry");
        },
        backgroundColor: Color(0xFF2C3333),
        child: const Icon(
          Icons.location_on_rounded,
        ),
      ),
      backgroundColor: Color(0xFFCBE4DE),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Hero(
                tag: "flag-${data["flagUrl"]}",
                child: Image(
                  image: NetworkImage(data["flagUrl"]),
                  width: 70.0,
                  height: 50.0,
                  fit: BoxFit.fill,
                ),
              )),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "COUNTRY",
            style: TextStyle(
                color: Color(0xFF0E8388).withAlpha(120),
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
                letterSpacing: 1),
          ),
          Hero(
            tag: "country-${data["countryName"]}",
            child: Text(
              data["countryName"].toUpperCase(),
              style: TextStyle(color: Color(0xFF0E8388), fontSize: 32.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(42, 12, 42, 12),
            child: Divider(
              color: Color(0xFF2C3333).withAlpha(120),
              height: 30.0,
              thickness: 2,
            ),
          ),
          Text(
            "TIME",
            style: TextStyle(
                color: Color(0xFF0E8388).withAlpha(120),
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
                letterSpacing: 1),
          ),
          Text(
            data["time"],
            style: TextStyle(color: Color(0xFF0E8388), fontSize: 64.0),
          )
        ],
      )),
    );
  }
}
