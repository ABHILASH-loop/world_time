import 'package:flutter/material.dart';
import 'package:world_time/response/date_time_response.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = "";
  Map data = {"countryName": "India", "flagUrl": "https://flagcdn.com/w320/in.png"};

  void getDateTime() async {
    DateTimeResponse response =
        DateTimeResponse(countryName: data["countryName"]);
    await response.getDateTime();
    Future.delayed(const Duration(seconds: 2));
    time = response.time;
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, "/home",
          arguments: {"countryName": data["countryName"], "time": time, "flagUrl":data["flagUrl"]}
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getDateTime();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments == null?
            data: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      /**/
      backgroundColor: Color(0xFFCBE4DE),
      body: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
            color: const Color(0xFF0E8388), size: 80.0),
      ),
    );
  }
}
