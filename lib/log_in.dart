import 'package:flutter/material.dart';
import 'package:flutter_application/bussness_logic.dart/auth_logic.dart';
import 'package:flutter_application/sign_up.dart';

class LogInPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
                  obj.signIn(userEmail, userPassword, context);
                },
                child: Text("Login")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: Text("Register")),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () => AuthLogic().signInWithGoogle(context),
                child: Text("Google sign in")),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: phoneController,
            ),
            ElevatedButton(
                onPressed: () => AuthLogic()
                    .phoneVerification(phoneController.text, context),
                child: Text("Phone Number"))
          ],
        ),
      ),
    );
  }
}
