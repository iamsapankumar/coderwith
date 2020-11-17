import 'package:badhat_b2b/ui/dashboard/orders/orders_controller.dart';
import 'package:badhat_b2b/widgets/app_bar.dart';
import 'package:badhat_b2b/widgets/widget_view.dart';
import 'package:flutter/material.dart';

import 'orders_placed_view.dart';
import 'orders_received_view.dart';
import '../../../utils/extensions.dart';

class OrdersView extends WidgetView<OrdersScreen, OrdersScreenState> {
  OrdersView(OrdersScreenState state) : super(state);
  final screens = <Widget>[OrdersReceivedView(), OrdersPlacedView()];
  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: <Widget>[
            MyAppBar("Orders").paddingAll(10),
              TabBar(
                unselectedLabelColor: Colors.grey,
                tabs: <Widget>[
                  Text("Received").fontSize(18).container(height: 35),
                  Text("Placed").fontSize(18).container(height: 35)],
                isScrollable: false,
                labelColor: Colors.black,
              ),
              Expanded(
                child: TabBarView(
                  children: screens,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
