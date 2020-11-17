import 'package:badhat_b2b/data/chat_room_response_entity.dart';
import 'package:badhat_b2b/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'more_view.dart';

class MoreScreen extends StatefulWidget {
  @override
  MoreScreenState createState() => MoreScreenState();
}

class MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) => MoreView(this);

  var menuItems = [
    "My Profile",
    "My Shop",
    "About Badhat",
    "Badhat Policies",
    "How to use Badhat",
  ];

  @override
  void initState() {
    if (userId != 1) {
      menuItems.add("Chat with Badhat");
    }

    super.initState();
  }

  void navigateToAdminChat() async {
    // get chat room id

    try {
      var response = await dio.get("checkOrCreateAdminRoom",
          options: Options(headers: {"Authorization": "Bearer ${token}"}));

//      print(response.data["data"]);
      ChatRoomResponseDataVendor d = ChatRoomResponseDataVendor(
          id: 1,
          name: "",
          businessName: "",
          image: "",
          roomId: response.data["data"]);
      Navigator.pushNamed(context, "chat", arguments: {
        "vendor": (d),
      });
    } on DioError catch (e) {
      showAlert(context, e.response.data["message"]);
    }
  }

  Future<void> logout() async {

    try {
      var response = await dio.get("logout",
          options: Options(headers: {"Authorization": "Bearer ${token}"}));

      var prefs = await SharedPreferences.getInstance();
      prefs.setString("token", null);
      Navigator.pushReplacementNamed(context, "login");
    } on DioError catch (e) {
      showAlert(context, e.response.data["message"]);
    }
  }
}
