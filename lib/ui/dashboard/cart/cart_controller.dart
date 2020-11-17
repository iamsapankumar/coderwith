import 'package:badhat_b2b/ui/dashboard/cart/cart_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/cart_response_entity.dart';
import '../../../generated/json/cart_response_entity_helper.dart';
import '../../../main.dart';

class CartController extends StatefulWidget {
  @override
  CartControllerState createState() => CartControllerState();
}

class CartControllerState extends State<CartController> {
  @override
  Widget build(BuildContext context) => CartView(this);

  // variable
  bool loading = true;
  bool placingOrder = false;
  List<CartResponseData> cartList = List();
  var token;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    var pref = await SharedPreferences.getInstance();
    token = pref.getString("token");
    requestCartApi();
    super.didChangeDependencies();
  }

  void requestCartApi() async {
    /*_updateLoading(true);*/
    try {
      var response = await dio.get('cart',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      /*_updateLoading(false);*/

      CartResponseEntity entity = CartResponseEntity();
      cartResponseEntityFromJson(entity, response.data);

      setState(() {
        cartList = entity.data;
        cartCountController.add(entity.data.length);
      });
    } on DioError catch (e) {
      _updateLoading(false);
    }
  }

  void requestPlaceOrderApi() async {
    /*_updateLoading(true);*/
    try {
      var response = await dio.get('placeOrder',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      /*_updateLoading(false);*/

      if (response.statusCode == 200) {
        cartCountController.add(0);
        Navigator.pop(context);
      }
    } on DioError catch (e) {
      _updateLoading(false);
    }
  }

  void _updateLoading(bool value) {
    if(!mounted) return;
    setState(() {
      loading = value;
    });
  }


}
