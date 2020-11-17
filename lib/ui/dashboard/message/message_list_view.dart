import 'package:badhat_b2b/ui/dashboard/message/message_controller.dart';
import 'package:badhat_b2b/widgets/app_bar.dart';
import 'package:badhat_b2b/widgets/widget_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../utils/extensions.dart';

class MessageListView extends WidgetView<MessagesScreen, MessagesScreenState> {
  MessageListView(MessagesScreenState state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            MyAppBar("Chats").paddingAll(10),
            Divider(
              thickness: 1.1,
            ),
            Expanded(
              child: loading
                  ? CircularProgressIndicator().center()
                  : rooms.isEmpty
                      ? Text("No Chat available").center()
                      : RefreshIndicator(
                          onRefresh: () async {
                            state.requestChatRoomsApi();
                          },
                          child: ListView.separated(
                              itemBuilder: (context, position) {
                                var item = rooms[position];
                                return ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: (item.vendor.image == null || item.vendor.image.isEmpty)
                                        ? Image.asset(
                                      "assets/images/no-image.jpg", width: 60, height: 60,)
                                        : CachedNetworkImage(
                                      imageUrl: item.vendor.image,
                                      width: 60,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(item.vendor.name),
                                  subtitle: Text(item.vendor.businessName),
                                  trailing: Icon(
                                    Icons.message,
                                    size: 20,
                                  ),
                                ).onClick(() {
                                  Navigator.of(context)
                                      .pushNamed("chat", arguments: {
                                    "vendor": item.vendor,
                                  });
                                });
                              },
                              separatorBuilder: (context, position) {
                                return Divider();
                              },
                              itemCount: rooms.length),
                        ),
            )
          ],
        ),
      ),
    );
  }
}
