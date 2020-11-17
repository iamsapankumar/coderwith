import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneController = TextEditingController();

  Future<void> phoneValidation() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneController.text.toString(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int resendToken) async {
          String smsCode = 'xxxx';
          PhoneAuthCredential phoneAuthCredential =
              PhoneAuthProvider.credential(
                  verificationId: verificationId, smsCode: smsCode);
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          print(verificationId);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                ),
              ),
              RaisedButton(
                  color: Colors.amberAccent,
                  onPressed: () {
                    phoneValidation();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
