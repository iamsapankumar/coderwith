import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/cart_response_entity.dart';
import '../../../main.dart';
import '../../../utils/extensions.dart';

class CartItemView extends StatefulWidget {
  final CartResponseData v;
  final VoidCallback callback;

  const CartItemView({Key key, this.v, this.callback}) : super(key: key);

  @override
  _CartItemViewState createState() => _CartItemViewState();
}

class _CartItemViewState extends State<CartItemView> {
  CartResponseDataProduct product;
  bool loading = false;
  String token;

  @override
  void didChangeDependencies() async {
    product = widget.v.product;
    var pref = await SharedPreferences.getInstance();
    token = pref.getString("token");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: product.image,
              placeholder: (context, url) => Container(
                color: Colors.grey.withOpacity(0.4),
                width: 100,
                height: 100,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(product.name).fontSize(15).fontWeight(FontWeight.w800),
                  Text("Price: Rs. ${product.price}/set").paddingTop(4),
                  Text("Quantity: ${widget.v.quantity}").paddingTop(4),
                  Text("Total: ${widget.v.quantity * double.parse(product.price)}")
                      .paddingTop(4),
                ],
              ).paddingLeft(16),
            ),
            loading
                ? CircularProgressIndicator()
                    .container(width: 24, height: 24)
                    .paddingAll(8)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ).paddingAll(4).onClick(() {
                        requestDeleteFromCart(widget.v.id);
                      }),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.do_not_disturb_on,
                            size: 31,
                            color: (product.moq==widget.v.quantity)? Colors.grey: Colors.purple,
                          ).paddingAll(2).onClick(() {
                            if(widget.v.quantity>product.moq){
                              removeProductFromCart();
                            }
                          }),
                          Text(widget.v.quantity.toString()),
                          Icon(
                            Icons.add_circle,
                            size: 31,
                            color: Colors.purple,
                          ).paddingAll(2).onClick(() {
                            addProductToCart();
                          }),
                        ],
                      ).paddingTop(16),
                    ],
                  )
          ],
        ),
      ),
    ).onClick(() {
      Navigator.pushNamed(context, "vendor_profile",
          arguments: {
            "user_id": product.userId,
          });
    });
  }
  void removeProductFromCart() async {
    _updateLoading(true);

    try {
      var response = await dio.post('removeFromCart',
          data: {
            "quantity": product.moq,
            "cart_id": widget.v.id,
          },
          options: Options(headers: {"Authorization": "Bearer $token"}));
      _updateLoading(false);
      cartCountController.add(response.data["data"]);
      widget.callback();

    } on DioError catch (e) {
      _updateLoading(false);
    }
  }
  void addProductToCart() async {
    _updateLoading(true);

    try {
      var response = await dio.post('addToCart',
          data: {
            "product_id": product.id,
            "quantity": product.moq,
            "vendor_id": product.userId,
          },
          options: Options(headers: {"Authorization": "Bearer $token"}));
      widget.callback();
      _updateLoading(false);
//      if (response.statusCode == 200) {
//        showAlert(context, "Product added");
//      }
    } on DioError catch (e) {
      _updateLoading(false);
    }
  }

  void requestDeleteFromCart(int id) async {
    try {
      _updateLoading(true);
      var response = await dio.delete('cart/delete/$id',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      widget.callback();
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
