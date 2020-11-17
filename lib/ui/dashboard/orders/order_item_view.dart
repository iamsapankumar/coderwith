import 'package:badhat_b2b/data/chat_room_response_entity.dart';
import 'package:badhat_b2b/data/order_placed_response_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/order_received_response_entity.dart';
import '../../../main.dart';
import '../../../utils/extensions.dart';

class OrderReceivedItemView extends StatefulWidget {
  final OrderReceivedResponseData data;
  final VoidCallback callback;

  const OrderReceivedItemView(this.callback, {Key key, this.data})
      : super(key: key);

  @override
  _OrderReceivedItemViewState createState() => _OrderReceivedItemViewState();
}

class _OrderReceivedItemViewState extends State<OrderReceivedItemView> {
  bool loading = false;

  void _updateLoading(bool value) {
    if (!mounted) return;
    setState(() {
      loading = value;
    });
  }

  void cancelOrder() async {
    _updateLoading(true);
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    try {
      var response = await dio.get('cancelOrder/${widget.data.id}',
          options: Options(headers: {"Authorization": "Bearer $token"}));

      widget.callback();

      if (!mounted) return;
      setState(() {});
    } on DioError catch (e) {
      _updateLoading(false);
    }
  }

  void acceptOrder() async {
    _updateLoading(true);
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var response = await dio.get('acceptOrder/${widget.data.id}',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      _updateLoading(false);
      widget.callback();

      if (!mounted) return;
      setState(() {});
    } on DioError catch (e) {
      _updateLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Image.asset(
              "assets/images/parcel_in.png",
              width: 42,
              height: 42,
            ),
            title: Text("Order: #${widget.data.id}"),
            subtitle: Text("${widget.data.createdAt}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.message,
                  color: Colors.black,
                ).paddingAll(8).onClick(() {
                  ChatRoomResponseDataVendor d = ChatRoomResponseDataVendor(
                      id: widget.data.user.id,
                      name: widget.data.user.name,
                      businessName: widget.data.user.businessName,
                      image: "",
                      roomId: widget.data.user.roomId);
                  Navigator.pushNamed(context, "chat", arguments: {
                    "vendor": (d),
                  });
                }),
                Icon(
                  Icons.call,
                  color: Colors.black,
                ).onClick(() {
                  callNumber(widget.data.user.mobile);
                }),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Rs. ${widget.data.getTotal()}")
                  .color(Colors.blue)
                  .paddingFromLTRB(12, 4, 12, 4)
                  .roundedBorder(Colors.blue.withOpacity(0.2)),
              Text("Items: ${widget.data.items.length}")
                  .color(Colors.green)
                  .paddingFromLTRB(12, 4, 12, 4)
                  .roundedBorder(Colors.green.withOpacity(0.2)),
              Text("${widget.data.status}")
                  .color(Colors.grey)
                  .paddingFromLTRB(12, 4, 12, 4)
                  .roundedBorder(Colors.grey.withOpacity(0.2)),
            ],
          ).paddingAll(8),
          if (loading)
            CircularProgressIndicator()
                .container(height: 16, width: 16)
                .center()
                .paddingAll(8)
          else
            Column(
              children: <Widget>[
                if (widget.data.status == "Placed")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        color: Colors.redAccent.withOpacity(0.3),
                        child: Text("Cancel"),
                        onPressed: () {
                          cancelOrder();
                        },
                      ).container(width: context.screenWidth() * 0.45),
                      FlatButton(
                        color: Colors.green.withOpacity(0.3),
                        child: Text("Accept"),
                        onPressed: () {
                          acceptOrder();
                        },
                      ).container(width: context.screenWidth() * 0.45),
                    ],
                  ).paddingAll(8)
              ],
            )
        ],
      ),
    ).onClick(() async {
      var x = await Navigator.pushNamed(context, 'placed_order_detail',
          arguments: {"id": widget.data.id});
      if (x != null) {
        widget.callback();
      }
    });
  }
}

// PLACED ORDER ITEM VIEW

class OrderPlacedItemView extends StatefulWidget {
  final OrderPlacedResponseData data;
  final VoidCallback callback;

  const OrderPlacedItemView(this.callback, this.data, {Key key})
      : super(key: key);

  @override
  _OrderPlacedItemViewState createState() => _OrderPlacedItemViewState();
}

class _OrderPlacedItemViewState extends State<OrderPlacedItemView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Image.asset(
              "assets/images/parcel_out.png",
              width: 42,
              height: 42,
            ),
            title: Text("Order: #${widget.data.id}"),
            subtitle: Text("${widget.data.createdAt}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.message,
                  color: Colors.black,
                ).paddingAll(8).onClick(() {
                  ChatRoomResponseDataVendor d = ChatRoomResponseDataVendor(
                      id: widget.data.vendor["id"],
                      name: widget.data.vendor["name"],
                      businessName: widget.data.vendor["business_name"],
                      image: "",
                      roomId: widget.data.vendor["room_id"]);
                  Navigator.pushNamed(context, "chat", arguments: {
                    "vendor": (d),
                  });
                }),
                Icon(
                  Icons.call,
                  color: Colors.black,
                ).paddingAll(8).onClick(() {
                  callNumber(widget.data.vendor["mobile"]);
                }),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Rs. ${widget.data.getTotal()}")
                  .color(Colors.blue)
                  .paddingFromLTRB(12, 4, 12, 4)
                  .roundedBorder(Colors.blue.withOpacity(0.2)),
              Text("Items: ${widget.data.items.length}")
                  .color(Colors.green)
                  .paddingFromLTRB(12, 4, 12, 4)
                  .roundedBorder(Colors.green.withOpacity(0.2)),
              Text("${widget.data.status}")
                  .color(Colors.grey)
                  .paddingFromLTRB(12, 4, 12, 4)
                  .roundedBorder(Colors.grey.withOpacity(0.2)),
            ],
          ).paddingAll(8),
        ],
      ),
    ).onClick(() async {
      var x = await Navigator.pushNamed(context, 'placed_order_detail',
          arguments: {"id": widget.data.id});
      if (x != null) {
        widget.callback();
      }
    });
  }
}
