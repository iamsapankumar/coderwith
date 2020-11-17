import 'package:badhat_b2b/main.dart';
import 'package:badhat_b2b/ui/dashboard/orders/orders_view.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  @override
  OrdersScreenState createState() => OrdersScreenState();
}

class OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) => OrdersView(this);

  @override
  void initState() {
    orderCountController.add(0);
    super.initState();
  }
}
