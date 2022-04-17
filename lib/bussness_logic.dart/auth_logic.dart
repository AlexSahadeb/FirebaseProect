import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/detailspage.dart';
import 'package:flutter_application/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthLogic {
  final box = GetStorage();
  Future signUp(email, password, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      var authCredential = userCredential.user;
      print(authCredential);
      if (authCredential!.uid.isNotEmpty) {
        box.write("id", authCredential.uid);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Fluttertoast.showToast(msg: "Sign up faild");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        Fluttertoast.showToast(msg: "The Password provided is too weak");
      } else if (e.code == "email-already-in-use") {
        Fluttertoast.showToast(msg: "The account exists for that email");
      }
    } catch (e) {}
  }

  Future signIn(email, password, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      var authCredential = userCredential.user;
      print(authCredential);
      if (authCredential!.uid.isNotEmpty) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Fluttertoast.showToast(msg: "Sign up faild");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        Fluttertoast.showToast(msg: "The Password provided is too weak");
      } else if (e.code == "email-already-in-use") {
        Fluttertoast.showToast(msg: "The account exists for that email");
      }
    } catch (e) {}
  }

  Future signInWithGoogle(context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? _user = userCredential.user;

    if (_user!.uid.isNotEmpty) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DetailsPage(_user)));
    } else {
      Fluttertoast.showToast(msg: "Worng");
    }
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _otpController = TextEditingController();
  Future phoneVerification(number, context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential _userCredential =
            await auth.signInWithCredential(credential);
        User? _user = _userCredential.user;
        if (_user!.uid.isNotEmpty) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailsPage(_user)));
        } else {
          Fluttertoast.showToast(msg: "Faild");
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          Fluttertoast.showToast(
              msg: 'The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Enter the OTP"),
                  content: Column(
                    children: [
                      TextField(
                        controller: _otpController,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            PhoneAuthCredential _phoneAuthCredential =
                                PhoneAuthProvider.credential(
                                    verificationId: verificationId,
                                    smsCode: _otpController.text);

                            UserCredential _userCredential = await auth
                                .signInWithCredential(_phoneAuthCredential);
                            User? _user = _userCredential.user;
                            if (_user!.uid.isNotEmpty) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsPage(_user)));
                            } else {
                              Fluttertoast.showToast(msg: "Faild");
                            }
                          },
                          child: Text("Continue"))
                    ],
                  ),
                ));
      },
      timeout: Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
