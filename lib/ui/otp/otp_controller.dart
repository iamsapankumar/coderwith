import 'dart:async';

import 'package:badhat_b2b/data/user_entity.dart';
import 'package:badhat_b2b/generated/json/user_entity_helper.dart';
import 'package:badhat_b2b/ui/otp/otp_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class OtpScreen extends StatefulWidget {
  @override
  OtpScreenState createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {

  TextEditingController username = TextEditingController();
  String submitOtp;
  String mobile;
  @override
  Widget build(BuildContext context) => OtpView(this);
  int counter = 30;
  Timer timer;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    counter = 30;
    if (timer != null) {
      timer.cancel();
    }
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (counter >0) {
          counter--;
        } else {
          /*counter = 0;*/
          timer.cancel();
        }
      });
    });
  }

  bool loading = false;
  final formKey = new GlobalKey<FormState>();

  void ExsistingUserOrNot() async {
    var pref = await SharedPreferences.getInstance();
    updateLoading(true);

    try {

      var response = await dio.post(dio.options.baseUrl + 'login', data: {
        "mobile": pref.getString("UserName"),
        "otp": pref.getInt("OTP"),
        "fcm_token": fcmToken,
      }
      );

      UserEntity entity = UserEntity();
      userEntityFromJson(entity, response.data);
      pref.setString("token", entity.data.accessToken);
      pref.setString("profile_image", entity.data.image);
      pref.setInt("user_id", entity.data.user.id);
      pref.setString("name", entity.data.user.name);
      pref.setString("business_name", entity.data.user.businessName);
      profileImage = entity.data.image;
      updateLoading(false);
      /*Navigator.pushNamedAndRemoveUntil(context, "dashboard", (route) => false);*/
    } on DioError catch (e) {
      updateLoading(false);
      showAlert(context, e.response.data["message"]);
    }
  }

  void updateLoading(bool value) {
    setState(() {
      loading = value;
    });
  }
  void resendOtp() async {

    updateLoading(true);

    try {
      var pref = await SharedPreferences.getInstance();
      var response = await dio.post(dio.options.baseUrl + 'resendOtp', data: {
        "mobile": pref.getString("UserName"),
      }
      );
      updateLoading(false);
      UserEntity entity = UserEntity();
      userEntityFromJson(entity, response.data);
      pref.setInt('OTP',response.data["data"]["otp"]);
      /*Navigator.pushNamed(context, "otp",arguments: {"username":pref.getString("UserName")});*/
    } on DioError catch (e) {
      updateLoading(false);
      showAlert(context, e.response.data["message"]);
    }


  }

  void checkUserStatus(String submitOtp) async{
    try{
    var pref = await SharedPreferences.getInstance();
    updateLoading(true);
    if(pref.getInt("OTP") == int.parse(submitOtp)){
     await ExsistingUserOrNot();
     updateLoading(false);
      if(pref.getString("name")!=null && pref.getString("business_name")!=null){
        updateLoading(true);
        Navigator.pushReplacementNamed(context, "dashboard");
        updateLoading(false);
      }
      else {
        Navigator.pushReplacementNamed(context, "register",arguments: {"mobile": pref.getString("UserName")});
      }

    }else {
      updateLoading(false);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DisplayAlert(
            title: "OTP",
            messageContent: "Otp is not matched.",
            alertIcon: FontAwesomeIcons.exclamationTriangle,
            iconColor: Colors.red)
            .displaySuccessMsg(context);
      });
    }
    }catch(e){
      updateLoading(false);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DisplayAlert(
            title: "OTP",
            messageContent: "Please enter correct otp",
            alertIcon: FontAwesomeIcons.exclamationTriangle,
            iconColor: Colors.red)
            .displaySuccessMsg(context);
      });
    }
  }
}


