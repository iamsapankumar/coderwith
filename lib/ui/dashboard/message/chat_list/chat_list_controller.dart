import 'package:badhat_b2b/ui/dashboard/message/chat_list/chat_list_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/chat_response_entity.dart';
import '../../../../data/chat_room_response_entity.dart';
import '../../../../generated/json/chat_response_entity_helper.dart';
import '../../../../main.dart';

class ChatScreen extends StatefulWidget {
  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) => ChatListView(this);
  ChatRoomResponseDataVendor vendor;
  bool loading = false;
  List<ChatResponseData> messages = List();
  bool firstTime = true;
  ScrollController chatListController = ScrollController();

  @override
  void didChangeDependencies() {
    if (vendor == null) {
      vendor = (ModalRoute.of(context).settings.arguments as Map)["vendor"];
      print(vendor.roomId);
      if (vendor.roomId != null) requestChatHistory(vendor.roomId);
    }

    super.didChangeDependencies();
  }

  void requestChatHistory(var roomId) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    if (firstTime) {
      _updateLoading(true);
      firstTime = false;
    }

    try {
      var response = await dio.get('chats/$roomId',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      _updateLoading(false);

      ChatResponseEntity entity = ChatResponseEntity();
      chatResponseEntityFromJson(entity, response.data);
      if (!mounted) return;
      Future.delayed(Duration(seconds: 5), () {
        requestChatHistory(roomId);
      });

      setState(() {
        messages = entity.data;

      });
    } on DioError catch (e) {
      _updateLoading(false);
    }
  }

  void _updateLoading(bool value) {
    if (!mounted) return;
    setState(() {
      loading = value;
    });
  }

  void addMessageToList(ChatResponseData data) {
    if (!mounted) return;
    setState(() {
      messages.add(data);
      chatListController.animateTo(chatListController.position.maxScrollExtent, curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500));
    });
  }
}
