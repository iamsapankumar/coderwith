import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/placed_order_detail_entity.dart';
import '../../../../generated/json/placed_order_detail_entity_helper.dart';
import '../../../../main.dart';
import 'placed_order_detail_view.dart';

class PlacedOrderDetailScreen extends StatefulWidget {
  @override
  PlacedOrderDetailScreenState createState() => PlacedOrderDetailScreenState();
}

class PlacedOrderDetailScreenState extends State<PlacedOrderDetailScreen> {
  @override
  Widget build(BuildContext context) => OrderDetailView(this);

  // variable
  bool loading = true;
  PlacedOrderDetailEntity data = PlacedOrderDetailEntity();

  @override
  void didChangeDependencies() {
    if (data != null) {
      var id = (ModalRoute.of(context).settings.arguments as Map)["id"];
      requestOrderDetailApi(id);
    }
    super.didChangeDependencies();
  }

  void _updateLoading(bool value) {
    if (!mounted) return;
    setState(() {
      loading = value;
    });
  }

  void requestOrderDetailApi(int id) async {
    _updateLoading(true);

    try {
      var response = await dio.get('order/$id',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      _updateLoading(false);

      if (!mounted) return;
      setState(() {
        placedOrderDetailEntityFromJson(data, response.data);
      });
    } on DioError catch (e) {
      _updateLoading(false);
    }
  }
}
