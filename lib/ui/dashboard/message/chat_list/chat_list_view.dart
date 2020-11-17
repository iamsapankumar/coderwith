import 'package:badhat_b2b/ui/dashboard/message/chat_list/chat_list_controller.dart';
import 'package:badhat_b2b/widgets/widget_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../../../../utils/extensions.dart';
import '../../../../data/send_message_response_entity.dart';
import '../../../../data/chat_response_entity.dart';
import '../../../../generated/json/send_message_response_entity_helper.dart';

class ChatListView extends WidgetView<ChatScreen, ChatScreenState> {
  ChatListView(ChatScreenState state) : super(state);

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
                  Navigator.pop(context);
                }),
                Expanded(
                  child: ListTile(
                    title: Text(state.vendor.name),
                    subtitle: Text(state.vendor.businessName),
                  ),
                ),
              ],
            ).paddingFromLTRB(8, 10, 8, 4),

            Divider(
              thickness: 1.1,
              height: 1.1,
            ),
            Flexible
              (
                child: state.loading
                    ? CircularProgressIndicator().center()
                    : Container(
                  color: Colors.grey.withOpacity(0.1),
                      child: ListView.builder(
                        controller: state.chatListController,
                          itemCount: state.messages.length,
                          itemBuilder: (context, position) {
                            var item = state.messages[position];
                            var self = item.senderId != state.vendor.id;
                            return Row(
                              mainAxisAlignment: self
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Card(
                                    color:
                                        self ? Color(0xFFdcf8c6) : Colors.white,
                                    child: Column(
                                      children: <Widget>[
                                        Text(item.createdAt).fontSize(9),
                                        Text(item.message).fontSize(16),
                                      ],
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    ).paddingAll(8),
                                    margin: const EdgeInsets.all(6),
                                    elevation: 1,
                                  ),
                                ),
                              ],
                            );
                          }),
                    )),
            ChatFieldSection(
              roomId: state.vendor.roomId,
              vendorId: state.vendor.id,
              callback: (data){
                state.addMessageToList(data);
              },
            ),
          ],
        ),
      ),
    );
  }
}

typedef ChatAddedCallback(ChatResponseData data);

class ChatFieldSection extends StatefulWidget {
  final roomId, vendorId;
  final ChatAddedCallback callback;

  const ChatFieldSection({Key key, this.roomId, this.vendorId, this.callback})
      : super(key: key);

  @override
  _ChatFieldSectionState createState() => _ChatFieldSectionState();
}

class _ChatFieldSectionState extends State<ChatFieldSection> {
  bool loading = false;
  TextEditingController messageController = TextEditingController();
  var token;

  @override
  void initState() {
    loadToken();
    super.initState();
  }

  void loadToken() async {
    var pref = await SharedPreferences.getInstance();
    token = pref.getString("token");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: messageController,
            decoration: InputDecoration(hintText: "Type your message"),
          ),
        ),
        loading
            ? CircularProgressIndicator()
            : Icon(
                Icons.send,
                size: 32,
              ).onClick(() {
                sendMessage();
              })
      ],
    ).paddingAll(8);
  }

  void sendMessage() async {
    if (messageController.text.isEmpty) {
      return;
    }
    updateLoading(true);
    try {
      var response = await dio.post('addChat',
          options: Options(headers: {"Authorization": "Bearer $token"}),
          data: {
            "room_id": widget.roomId,
            "vendor_id": widget.vendorId,
            "message": messageController.text,
          });
      SendMessageResponseEntity entity = SendMessageResponseEntity();
      sendMessageResponseEntityFromJson(entity,response.data);
      widget.callback(entity.data);

      messageController.clear();
      updateLoading(false);
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
}
