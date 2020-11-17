import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../../../../utils/extensions.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  Icons.keyboard_arrow_left,
                  size: 32,
                ).paddingRight(4).onClick(() {
                  Navigator.pop(context, {});
                }),
                Expanded(
                  child: Text("Change Password")
                      .fontWeight(FontWeight.bold)
                      .fontSize(22)
                      .paddingLeft(8),
                )
              ],
            ).paddingFromLTRB(8, 10, 8, 4),
            Divider(
              thickness: 1.1,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return "Password cannot be less than 4 digit.";
                          }
                          return null;
                        },
                        obscureText: true,
                        controller: currentPassword,
                        decoration: InputDecoration(
                          hintText: "Current Password",
                          border: OutlineInputBorder(),
                        ),
                      ).paddingAll(4),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty || value.length < 6) {
                            return "Enter at least 6 digit new password";
                          }
                          return null;
                        },
                        controller: newPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "New Password",
                          border: OutlineInputBorder(),
                        ),
                      ).paddingAll(4),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty || value != newPassword.text) {
                            return "Confirm password doesn't match new password";
                          }
                          return null;
                        },
                        controller: confirmPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(),
                        ),
                      ).paddingAll(4),
                      Text("Submit")
                          .color(Colors.white)
                          .roundedBorder(
                            Theme.of(context).accentColor,
                            height: 44,
                          )
                          .paddingAll(16)
                          .onClick(() {
                        handleSubmitPress();
                      }),
                    ],
                  ).paddingAll(8),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void handleSubmitPress() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    } else {
      return;
    }

    try {
      var response = await dio.post(
        'changePassword',
        data: {
          "current_password": currentPassword.text,
          "new_password": newPassword.text,
          "confirm_password": confirmPassword.text
        },
          options: Options(headers: {"Authorization": "Bearer $token"})
      );
      updateLoading(false);
      Navigator.pop(context);
    } on DioError catch (e) {
      updateLoading(false);
      showAlert(context, e.response.data["message"]);
    }
  }

  void updateLoading(bool value) {
    if (!mounted) return;
    setState(() {
      loading = value;
    });
  }
}
