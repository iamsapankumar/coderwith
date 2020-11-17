import 'dart:async';

import 'package:badhat_b2b/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String tokenPref;

  Future<Null> initUniLinks() async {
    try {
      String initialLink = await getInitialLink();
      if (initialLink == null) {
        return;
      }
      print(initialLink);
      destinationPayloadId =
          int.parse(initialLink.substring(initialLink.lastIndexOf("/") + 1));
      if (initialLink.contains("product")) {
//        print(destinationPayloadId);
        destinationName = "product_detail";
      }
      if (initialLink.contains("user")) {
        destinationName = "vendor_profile";
      }
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }

  void navigateToLogin() async {
    Timer(Duration(seconds: 1), () async {
      await requestAppStateApi();

      if (tokenPref == null || tokenPref.isEmpty) {
        Navigator.of(context).pushReplacementNamed("info");
      } else {
        Navigator.of(context).pushReplacementNamed("dashboard");
      }
    });
  }

  Future<void> requestAppStateApi() {
    if (tokenPref != null) {
      return dio
          .get(
            'appState',
          options: Options(headers: {"Authorization": "Bearer $tokenPref"})
          )
          .catchError((e) {})
          .then((response) {
        if (response.statusCode == 200) {
          print(response.data["data"]["notification"]);
          notificationCountController.add(response.data["data"]["notification"]);
          cartCountController.add(response.data["data"]["cart"]);
          orderCountController.add(response.data["data"]["order"]);
        } else {}
      }).catchError((e) {});
    }
    return Future.value(null);
  }

  @override
  void didChangeDependencies() async {
    await loadToken();
    if (tokenPref != null) await initUniLinks();
    navigateToLogin();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          child: Image.asset(
            "assets/images/splash_bg.jpg",
            fit: BoxFit.cover,
          )),
    );
  }

  Future<Null> loadToken() async {
    var pref = await SharedPreferences.getInstance();
    tokenPref = pref.getString("token");
  }
}
