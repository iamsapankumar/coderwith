import 'package:badhat_b2b/ui/notification/notification_controller.dart';
import 'package:badhat_b2b/widgets/widget_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/extensions.dart';

class NotificationView
    extends WidgetView<NotificationsScreen, NotificationsScreenState> {
  NotificationView(NotificationsScreenState state) : super(state);

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
                  child: Text("Notifications")
                      .fontWeight(FontWeight.bold)
                      .fontSize(20),
                )
              ],
            ).paddingFromLTRB(8, 10, 8, 4),
            Divider(
              thickness: 1.2,
            ),
            Expanded(
              child: state.loading
                  ? CircularProgressIndicator().center()
                  : ListView.separated(
                      separatorBuilder: (context, position) {
                        return Divider();
                      },
                      itemCount: state.notifications.length,
                      itemBuilder: (context, position) {
                        var item = state.notifications[position];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(item.createdAt)
                                .fontSize(10)
                                .alignTo(Alignment.centerLeft)
                                .paddingLeft(8),
                            Text(item.message).fontSize(16).paddingAll(6),
                          ],
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
