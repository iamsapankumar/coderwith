import 'package:badhat_b2b/ui/dashboard/message/message_list_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/chat_room_response_entity.dart';
import '../../../generated/json/chat_room_response_entity_helper.dart';
import '../../../main.dart';

class MessagesScreen extends StatefulWidget {
  @override
  MessagesScreenState createState() => MessagesScreenState();
}

bool loading = true;
List<ChatRoomResponseData> rooms = List<ChatRoomResponseData>();
class MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) => MessageListView(this);

  // variables


  @override
  void initState() {
    requestChatRoomsApi();
    super.initState();
  }

  void requestChatRoomsApi() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    /*_updateLoading(true);*/
    try {
      var response = await dio.get('rooms',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      _updateLoading(false);

      ChatRoomResponseEntity entity = ChatRoomResponseEntity();
      chatRoomResponseEntityFromJson(entity, response.data);

      setState(() {
        rooms = entity.data;
      });
    } on DioError catch (e) {
      _updateLoading(false);
    }
  }

  void _updateLoading(bool value) {
    setState(() {
      loading = value;
    });
  }
}
