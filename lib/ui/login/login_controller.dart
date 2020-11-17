import 'package:badhat_b2b/main.dart';
import 'package:badhat_b2b/ui/login/login_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/user_entity.dart';
import '../../generated/json/user_entity_helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) => LoginView(this);

  // variables
/*  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loading = false;
  final formKey = new GlobalKey<FormState>();

  void requestLogin() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    } else {
      return;
    }

    updateLoading(true);

    try {
      var response = await dio.post(dio.options.baseUrl + 'sendOtp', data: {
        "mobile": username.text,
        "password": password.text,
        "fcm_token": fcmToken,
      }
      );
      updateLoading(false);
      UserEntity entity = UserEntity();
      userEntityFromJson(entity, response.data);
      var pref = await SharedPreferences.getInstance();
      pref.setString("token", entity.data.accessToken);
      pref.setString("profile_image", entity.data.image);
      pref.setInt("user_id", entity.data.user.id);
      profileImage = entity.data.image;
      Navigator.pushNamedAndRemoveUntil(context, "dashboard", (route) => false);
    } on DioError catch (e) {
      updateLoading(false);
      showAlert(context, e.response.data["message"]);
    }
  }

  void _handleLoginResponse(Response<dynamic> response) {
    updateLoading(false);
    if (response.statusCode == 200) {
      UserEntity entity = UserEntity();
      userEntityFromJson(entity, response.data);
      // save to prefs
      Navigator.pushNamedAndRemoveUntil(context, "dashboard", (route) => false);
    } else {
      showAlert(context, response.statusMessage);
    }
  }

  void updateLoading(bool value) {
    setState(() {
      loading = value;
    });
  }*/

  //Todo -- Rahul: Change the login code.

  TextEditingController username = TextEditingController();
  bool loading = false;
  final formKey = new GlobalKey<FormState>();


  void requestOtp() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    } else {
      return;
    }

    updateLoading(true);

    try {
      var pref = await SharedPreferences.getInstance();
      var response = await dio.post(dio.options.baseUrl + 'sendOtp', data: {
        "mobile": username.text,
      }
      );
      updateLoading(false);
      pref.setString("UserName", username.text);
      UserEntity entity = UserEntity();
      userEntityFromJson(entity, response.data);
      pref.setInt('OTP',response.data["data"]["otp"]);
      Navigator.pushNamed(context, "otp",arguments: {"username":username.text});
    } on DioError catch (e) {
      updateLoading(false);
      showAlert(context, e.response.data["message"]);
    }


  }

  /*void  _handleOtpResponse(Response<dynamic> response) async {
    updateLoading(false);


    if (response.data["status"] == "success") {

      UserEntity entity = UserEntity();
      userEntityFromJson(entity, response.data);
      // save to prefs
       Navigator.pushNamedAndRemoveUntil(context, "dashboard", (route) => false);
    } else {
      showAlert(context, response.statusMessage);
    }
  }*/

  void updateLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

}
