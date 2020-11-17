import 'package:badhat_b2b/ui/dashboard/products/detail/product_detail_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/product_detail_entity.dart';
import '../../../../generated/json/product_detail_entity_helper.dart';
import '../../../../main.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) => ProductDetailView(this);

  bool loading = true;
  ProductDetailData product;
  String token;

  @override
  void didChangeDependencies() {
    var arguments = ModalRoute.of(context).settings.arguments;
    if (arguments != null) {
      var id = (arguments as Map)["id"];
      requestProductDetailApi(id);
    }

    super.didChangeDependencies();
  }

  void requestProductDetailApi(id) async {
    var pref = await SharedPreferences.getInstance();
    token = pref.getString("token");
    dio
        .get(
      'product/$id}',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    )
        .catchError((e) {

    }).then((response) {
      updateLoading(false);
      if (response.statusCode == 200) {
        ProductDetailEntity entity = ProductDetailEntity();
        productDetailEntityFromJson(entity, response.data);
        product = entity.data;
        if(!mounted) return;
        setState(() {

        });
      } else {}
    }).catchError((e) {});
  }

  void updateLoading(bool value) {
    if (!mounted) return;
    setState(() {
      loading = value;
    });
  }
}
