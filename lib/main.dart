import 'dart:async';

import 'package:badhat_b2b/ui/dashboard/cart/cart_controller.dart';
import 'package:badhat_b2b/ui/dashboard/dashboard_controller.dart';
import 'package:badhat_b2b/ui/dashboard/message/chat_list/chat_list_controller.dart';
import 'package:badhat_b2b/ui/dashboard/more/about/about_controller.dart';
import 'package:badhat_b2b/ui/dashboard/more/change_password/change_password_controller.dart';
import 'package:badhat_b2b/ui/dashboard/more/how_to_use.dart';
import 'package:badhat_b2b/ui/dashboard/more/policies/policies_controller.dart';
import 'package:badhat_b2b/ui/dashboard/more/profile/my_profile_controller.dart';
import 'package:badhat_b2b/ui/dashboard/orders/detail/placed_order_detail_controller.dart';
import 'package:badhat_b2b/ui/dashboard/products/add/add_product_controller.dart';
import 'package:badhat_b2b/ui/dashboard/products/detail/product_detail_controller.dart';
import 'package:badhat_b2b/ui/dashboard/search/search_controller.dart';
import 'package:badhat_b2b/ui/dashboard/vendor/vendor_profile_controller.dart';
import 'package:badhat_b2b/ui/forgotpassword/forgot_password_controller.dart';
import 'package:badhat_b2b/ui/info/info_controller.dart';
import 'package:badhat_b2b/ui/login/login_controller.dart';
import 'package:badhat_b2b/ui/notification/notification_controller.dart';
import 'package:badhat_b2b/ui/otp/otp_controller.dart';
import 'package:badhat_b2b/ui/register/register_controller.dart';
import 'package:badhat_b2b/ui/splash/splash_screen.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

var profileImage;
String destinationName;
int destinationPayloadId;
int userId = 0;
String token = "";
String fcmToken = "";
BehaviorSubject<int> cartCountController = BehaviorSubject();
BehaviorSubject<int> notificationCountController =
    BehaviorSubject();
BehaviorSubject<int> orderCountController = BehaviorSubject();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

FirebaseMessaging _firebaseMessaging= FirebaseMessaging();

Future onDidReceiveLocalNotification(
    int id, String title, String body, String payload) async {
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];


  }
}

Future selectNotification(String payload) async {
  if (payload != null) {
    debugPrint('notification payload: ' + payload);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var pref = await SharedPreferences.getInstance();
  profileImage = pref.getString("profile_image");

  fcmToken = pref.getString("fcm_token");
//  print(fcmToken);
  if (fcmToken == null) {
    // fetch token

    var x = await _firebaseMessaging.getToken();
    fcmToken = x;
    pref.setString("fcm_token", x);
  }
  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print(message);
      var notification = message["notification"];
      print(notification);
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'badhat_push', 'Badhat App', 'Push related to user interactions',
          importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(123, notification['title'],
          notification['body'], platformChannelSpecifics,
          payload: null);
    },
    onBackgroundMessage: myBackgroundMessageHandler,
    onLaunch: (Map<String, dynamic> message) async {

    },
    onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");

    },
  );


  // on token refresh
  FirebaseMessaging().onTokenRefresh.listen((event) {
    pref.setString("fcm_token", event);
  });

  var initializationSettingsAndroid =
      AndroidInitializationSettings('badhat_logo');
  var initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
  onSelectNotification: selectNotification);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Badhat B2b',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xfffd8f19),
        accentColor: Color(0xff4f9c2f),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        "info": (context) => InfoScreen(),
        "login": (context) => LoginScreen(),
        "otp": (context) => OtpScreen(),
        "register": (context) => RegisterScreen(),
        "dashboard": (context) => DashboardScreen(),
        "add_product": (context) => AddProductScreen(),
        "search": (context) => SearchController(),
        "vendor_profile": (context) => VendorProfileController(),
        "cart": (context) => CartController(),
        "placed_order_detail": (context) => PlacedOrderDetailScreen(),
        "chat": (context) => ChatScreen(),
        "product_detail": (context) => ProductDetailScreen(),
        "my_profile": (context) => MyProfileScreen(),
        "policies": (context) => PolicyScreen(),
        "about": (context) => AboutScreen(),
        "change_password": (context) => ChangePasswordScreen(),
        "notifications": (context) => NotificationsScreen(),
        "how_to": (context) => HowToUse(),
        "forgot_password": (context) => ForgotPasswordScreen(),
      },
    );
  }
}


class DisplayAlert {
  String title;
  String messageContent;
  IconData alertIcon;
  Color iconColor;

  DisplayAlert(
      {this.title, this.messageContent, this.alertIcon, this.iconColor});

  displaySuccessMsg(BuildContext context) {
    Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(2),
      icon: Icon(
        alertIcon,
        size: 20.0,
        color: iconColor,
      ),
      borderRadius: 10,
      isDismissible: true,
      backgroundGradient: LinearGradient(
        //colors: [Colors.green,Colors.amberAccent],
      ),
      titleText: Text(
        title,
        style: TextStyle(
            fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      messageText: Text(messageContent,
          style: TextStyle(fontSize: 12, color: Colors.white)),
      duration: Duration(seconds: 5),
    )..show(context);
  }
}


void showAlert(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("Okay"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      });
}

callNumber(String number) async {
  bool res = await FlutterPhoneDirectCaller.callNumber(number);
}

Dio _instance() {
  var dio = Dio();
  dio.options.baseUrl = "https://badhat.app/api/";
  /*dio.options.baseUrl = "http://192.168.43.109/badhat/public/api/";*/
  dio.options.responseType = ResponseType.json;
  dio.options.method = "POST";
  dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  return dio;
}

final dio = _instance();
