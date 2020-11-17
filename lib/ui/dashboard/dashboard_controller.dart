import 'package:badhat_b2b/main.dart';
import 'package:badhat_b2b/ui/dashboard/home/home_controller.dart';
import 'package:badhat_b2b/ui/dashboard/message/message_controller.dart';
import 'package:badhat_b2b/ui/dashboard/more/more_controller.dart';
import 'package:badhat_b2b/ui/dashboard/orders/orders_controller.dart';
import 'package:badhat_b2b/ui/dashboard/products/products_controller.dart';
import 'package:bottom_navigation_badge/bottom_navigation_badge.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var screens = [
    HomeScreen(),
    ProductsScreen(),
    MessagesScreen(),
    OrdersScreen(),
    MoreScreen()
  ];
  var _items = [
    BottomNavigationBarItem(title: Text("Home"), icon: Icon(Icons.home)),
    BottomNavigationBarItem(title: Text("Products"), icon: Icon(Icons.book)),
    BottomNavigationBarItem(title: Text("Chat"), icon: Icon(Icons.chat)),
    BottomNavigationBarItem(
      title: Text("Orders"),
      icon: Icon(Icons.airport_shuttle),
    ),
    BottomNavigationBarItem(title: Text("More"), icon: Icon(Icons.menu)),
  ];
  int screenIndex = 0;
//  BottomNavigationBadge badger;

  @override
  void initState() {
//    badger = new BottomNavigationBadge(
//        backgroundColor: Colors.green,
//        badgeShape: BottomNavigationBadgeShape.circle,
//        textColor: Colors.white,
//        position: BottomNavigationBadgePosition.topRight,
//        textSize: 9);
//
//    orderCountController.stream.listen((value) {
//      if (value != null)
//        badger.setBadge(_items, value.toString(), 3);
//      else
//        badger.setBadge(_items, "0", 3);
//    });

    Future.delayed(Duration(milliseconds: 1500), () {
      if (destinationName != null && destinationPayloadId != null) {
        if (destinationName == "product_detail") {
          Navigator.of(context).pushNamed("product_detail",
              arguments: {"id": destinationPayloadId});
        }
        if (destinationName == "vendor_profile") {
          Navigator.pushNamed(context, "vendor_profile", arguments: {
            "user_id": destinationPayloadId,
          });
        }
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    var sp = await SharedPreferences.getInstance();
    userId = sp.getInt("user_id");
    token = sp.getString("token");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: screenIndex,
        type: BottomNavigationBarType.fixed,
        items: _items,
        onTap: (index) {
          setState(() {
            screenIndex = index;
          });
        },
      ),
      body: screens[screenIndex],
    );
  }
}
