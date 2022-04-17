import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/bussness_logic.dart/auth_logic.dart';
import 'package:flutter_application/log_in.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogInPage()));
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () => AuthLogic().signInWithGoogle(context),
                child: Text("Google sign in")),
          ],
        ),
      ),
    );
  }
}
