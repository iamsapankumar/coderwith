import 'package:badhat_b2b/data/user_detail_response_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../../utils/extensions.dart';

class VendorProductItem extends StatefulWidget {
  final UserDetailResponseDataProduct product;
  final bool sameUser;

  const VendorProductItem(this.product, this.sameUser, {key}) : super(key: key);

  @override
  _VendorProductItemState createState() => _VendorProductItemState();
}

class _VendorProductItemState extends State<VendorProductItem> {
  bool loading = false;
  String token;

  @override
  void didChangeDependencies() async {
    var pref = await SharedPreferences.getInstance();
    token = pref.getString("token");
    super.didChangeDependencies();
  }

  void addProductToCart() async {
    _updateLoading(true);

    try {
      var response = await dio.post('addToCart',
          data: {
            "product_id": widget.product.id,
            "quantity": widget.product.moq,
            "vendor_id": widget.product.userId,
          },
          options: Options(headers: {"Authorization": "Bearer $token"}));
      _updateLoading(false);
      if (response.statusCode == 200) {
        cartCountController.add(response.data["data"]);
        showAlert(context, "Product added");
      }
    } on DioError catch (e) {
      _updateLoading(false);
    }
  }

  void _updateLoading(bool value) {
    setState(() {
      loading = value;
    });
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
              imageUrl: widget.product.image,
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
                  Text(widget.product.name)
                      .fontSize(15)
                      .fontWeight(FontWeight.w800),
                  Text("Rs. ${widget.product.price}/set"),
                  Text("MOQ: ${widget.product.moq}"),
                ],
              ).paddingLeft(16),
            ),
            loading
                ? CircularProgressIndicator()
                    .container(width: 24, height: 24)
                    .paddingAll(8)
                : !widget.sameUser?Text("Add to cart")
                    .fontSize(11)
                    .paddingAll(8)
                    .roundedBorder(
                        Theme.of(context).primaryColor.withOpacity(0.5))
                    .onClick(() {
                    addProductToCart();
                  }).paddingAll(8): Container(),
          ],
        ),
      ),
    ).onClick(() {
      Navigator.of(context)
          .pushNamed("product_detail", arguments: {"id": widget.product.id});
    });
  }
}
