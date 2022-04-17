import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application/log_in.dart';
import 'package:get_storage/get_storage.dart';

class SplashPage extends StatelessWidget {
  final box = GetStorage();
  Future chooseScreen(context) async {
    var userId = await box.read("id");
    if (userId != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LogInPage()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LogInPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () => chooseScreen(context));
    return Scaffold(
        body: Center(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.green, Colors.blue])),
        child: Text(
          "Splash Page",
          style: TextStyle(
              color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
    ));
  }
}
