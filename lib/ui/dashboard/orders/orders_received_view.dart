import 'package:badhat_b2b/ui/dashboard/orders/order_item_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/order_received_response_entity.dart';
import '../../../generated/json/order_received_response_entity_helper.dart';
import '../../../main.dart';
import '../../../utils/extensions.dart';

class OrdersReceivedView extends StatefulWidget {
  @override
  _OrdersReceivedViewState createState() => _OrdersReceivedViewState();
}
bool loading = true;
List<OrderReceivedResponseData> orders = List<OrderReceivedResponseData>();
class _OrdersReceivedViewState extends State<OrdersReceivedView> {


  @override
  void didChangeDependencies() {
    requestReceivedOrdersApi();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: loading
                ? CircularProgressIndicator().center()
                : orders.isEmpty
                    ? Text("No orders received").center()
                    : RefreshIndicator(
                        onRefresh: () async {
                          requestReceivedOrdersApi();
                        },
                        child: ListView.builder(
                            itemCount: orders.length,
                            itemBuilder: (context, position) {
                              return OrderReceivedItemView(
                                () {
                                  requestReceivedOrdersApi();
                                },
                                data: orders[position],
                              );
                            }),
                      ),
          ),
        ],
      ),
    );
  }

  void requestReceivedOrdersApi() async {
    _updateLoading(true);
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    try {
      var response = await dio.get('receivedOrders',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      _updateLoading(false);
      OrderReceivedResponseEntity entity = OrderReceivedResponseEntity();
      orderReceivedResponseEntityFromJson(entity, response.data);

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
