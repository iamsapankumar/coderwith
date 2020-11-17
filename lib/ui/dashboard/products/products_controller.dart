import 'package:badhat_b2b/main.dart';
import 'package:badhat_b2b/ui/dashboard/products/products_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/product_entity.dart';
import '../../../generated/json/product_entity_helper.dart';

class ProductsScreen extends StatefulWidget {
  @override
  ProductsScreenState createState() => ProductsScreenState();
}

// variable
List<ProductData> products = List();
bool loading = false;
class ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) => ProductsView(this);



  @override
  void initState() {
    loadProducts();
    super.initState();
  }

  void loadProducts() async {
   // updateLoading(true);
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var response = await dio.get('products',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      updateLoading(false);
      ProductEntity entity = ProductEntity();
      productEntityFromJson(entity, response.data);
      setState(() {
        products = entity.data;
      });
    } on DioError catch (e) {
      updateLoading(false);
    }
  }

  void updateLoading(bool value) {
    setState(() {
      loading = value;
    });
  }
}
