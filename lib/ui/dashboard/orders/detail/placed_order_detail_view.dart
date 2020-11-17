import 'package:badhat_b2b/ui/dashboard/orders/detail/placed_order_detail_controller.dart';
import 'package:badhat_b2b/widgets/widget_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../../../../utils/extensions.dart';

class OrderDetailView
    extends WidgetView<PlacedOrderDetailScreen, PlacedOrderDetailScreenState> {
  OrderDetailView(PlacedOrderDetailScreenState state) : super(state);

  void cancelOrder() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var response = await dio.get('cancelOrder/${state.data.data.id}',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      state.requestOrderDetailApi(state.data.data.id);
    } on DioError catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: state.loading
          ? CircularProgressIndicator().center()
          : SafeArea(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.keyboard_arrow_left,
                        size: 32,
                      ).paddingRight(4).onClick(() {
                        Navigator.pop(context, {});
                      }),
                      Expanded(
                        child: Text("Order")
                            .fontWeight(FontWeight.bold)
                            .fontSize(22)
                            .paddingLeft(8),
                      )
                    ],
                  ).paddingFromLTRB(8, 10, 8, 4),
                  Divider(
                    thickness: 1.1,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Order Number")
                                      .fontWeight(FontWeight.w700),
                                  Text("#${state.data.data.id}"),
                                ],
                              ).paddingAll(8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Total Items").fontWeight(FontWeight.w700),
                                  Text("${state.data.data.items.length}"),
                                ],
                              ).paddingAll(8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Order Amount")
                                      .fontWeight(FontWeight.w700),
                                  Text("Rs. ${state.data.data.getTotal()}"),
                                ],
                              ).paddingAll(8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Date").fontWeight(FontWeight.w700),
                                  Text("${state.data.data.createdAt}"),
                                ],
                              ).paddingAll(8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Status").fontWeight(FontWeight.w700),
                                  Text("${state.data.data.status}"),
                                ],
                              ).paddingAll(8),
                            ],
                          ).paddingAll(8),
                          Divider(
                            thickness: 5,
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Customer").fontWeight(FontWeight.w700),
                                  Text("${state.data.data.user.name}"),
                                ],
                              ).paddingAll(8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Address").fontWeight(FontWeight.w700),
                                  Text("${state.data.data.user.district} - ${state.data.data.user.pincode}"),
                                ],
                              ).paddingAll(8),
                              Divider(
                                thickness: 5,
                              ),
                            ],
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, position) {
                                var item = state.data.data.items[position];
                                return ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      imageUrl: item.product.image,
                                      fit: BoxFit.cover,
                                      width: 60,
                                    ),
                                  ),
                                  title: Text(
                                      item.product.name + " @ " + item.price),
                                  subtitle:
                                      Text(item.product.vendor.businessName),
                                  trailing: Text("Qty: ${item.quantity}"),
                                ).onClick(() {
                                  Navigator.pushNamed(context, "vendor_profile",
                                      arguments: {
                                        "user_id": item.product.userId,
                                      });
                                });
                              },
                              separatorBuilder: (context, position) {
                                return Divider();
                              },
                              itemCount: state.data.data.items.length),
                          if (state.data.data.status != "Cancelled")
                            FlatButton(
                              color: Colors.redAccent.withOpacity(0.3),
                              child: Text("Cancel Order"),
                              onPressed: () {
                                cancelOrder();
                              },
                            )
                                .container(width: context.screenWidth())
                                .paddingAll(16),

                          Text("Note:").color(Colors.red).fontSize(16).fontWeight(FontWeight.bold).paddingFromLTRB(16, 10, 0, 0),
                          Text("1. All payment & Delivery terms will be discussed between buyers and sellers").paddingFromLTRB(10, 10, 0, 0),
                          Text("2. Badhat helps in connecting & booking orders only").paddingFromLTRB(10, 10, 0, 0),
                          Text("3. Badhat does not offer any kind of assurance on products").paddingFromLTRB(10, 10, 0, 0),
                          SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
