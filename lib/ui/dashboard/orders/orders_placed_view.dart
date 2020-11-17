import 'package:badhat_b2b/ui/dashboard/orders/order_item_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/order_placed_response_entity.dart';
import '../../../generated/json//order_placed_response_entity_helper.dart';
import '../../../main.dart';
import '../../../utils/extensions.dart';

class OrdersPlacedView extends StatefulWidget {
  @override
  _OrdersPlacedViewState createState() => _OrdersPlacedViewState();
}
bool loading = true;
List<OrderPlacedResponseData> orders = List();
class _OrdersPlacedViewState extends State<OrdersPlacedView> {


  @override
  void didChangeDependencies() {
    requestPlacedOrdersApi();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
//          Text("Placed")
//              .fontSize(22)
//              .fontWeight(FontWeight.bold)
//              .color(Colors.black)
//              .alignTo(Alignment.centerLeft)
//              .paddingAll(24),
          Expanded(
            child: loading
                ? CircularProgressIndicator().center()
                : orders.isEmpty
                    ? Text("No orders has been placed yet.").center()
                    : RefreshIndicator(
                        onRefresh: () async {
                          requestPlacedOrdersApi();
                        },
                        child: ListView.builder(
                            itemCount: orders.length,
                            itemBuilder: (context, position) {
                              return OrderPlacedItemView(() {
                                requestPlacedOrdersApi();
                              }, orders[position]);
                            }),
                      ),
          )
        ],
      ),
    );
  }

  void requestPlacedOrdersApi() async {
    _updateLoading(true);
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    try {
      var response = await dio.get('placedOrders',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      _updateLoading(false);
      OrderPlacedResponseEntity entity = OrderPlacedResponseEntity();
      orderPlacedResponseEntityFromJson(entity, response.data);

      if (entity.data.isNotEmpty) {
        orders = entity.data;
      }
      if (!mounted) return;
      setState(() {});
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
}
