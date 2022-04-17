import 'package:flutter/material.dart';
import 'package:flutter_application/bussness_logic.dart/auth_logic.dart';
import 'package:flutter_application/log_in.dart';

import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: emailController,
            ),
            TextField(
              controller: passController,
            ),
            ElevatedButton(
                onPressed: () {
                  final userEmail = emailController.text;
                  final userPassword = passController.text;
                  var obj = AuthLogic();
                  obj.signUp(userEmail, userPassword, context);
                },
                child: Text("Register")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogInPage()));
                },
                child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
