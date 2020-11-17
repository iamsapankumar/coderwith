import 'package:badhat_b2b/ui/notification/notification_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../data/notification_response_entity.dart';
import '../../generated/json/notification_response_entity_helper.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  NotificationsScreenState createState() => NotificationsScreenState();
}

class NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) => NotificationView(this);
  String token;
  bool loading = false;
  List<NotificationResponseData> notifications = List<NotificationResponseData>();

  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    var pref = await SharedPreferences.getInstance();
    token = pref.getString("token");
    requestNotificationsApi();
    updateReadStatus();
    super.didChangeDependencies();
  }

  void requestNotificationsApi() async {
    _updateLoading(true);
    try {
      var response = await dio.get('notifications',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      _updateLoading(false);
      NotificationResponseEntity entity = NotificationResponseEntity();
      notificationResponseEntityFromJson(entity,response.data);

      if (!mounted) return;
      setState(() {
        notifications = entity.data;
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

  void updateReadStatus() async{
    try {
      var response = await dio.get('markAllRead',
          options:
          Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        notificationCountController.add(0);
      }
    } on DioError catch (e) {}
  }


}
