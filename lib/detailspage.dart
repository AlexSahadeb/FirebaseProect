import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage(this.user);
  User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(user.email.toString())),
    );
  }
}
