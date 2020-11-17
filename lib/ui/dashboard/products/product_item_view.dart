import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/product_entity.dart';
import '../../../main.dart';
import '../../../utils/extensions.dart';

class ProductItemView extends StatefulWidget {
  final ProductData product;
  final VoidCallback callback;

  const ProductItemView({Key key, this.product, this.callback})
      : super(key: key);

  @override
  _ProductItemViewState createState() => _ProductItemViewState();
}

class _ProductItemViewState extends State<ProductItemView> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: widget.product.image,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        colorFilter:
                            ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                  ),
                ),
              //   placeholder: (context, url) => Container(
              //     color: Colors.grey.withOpacity(0.4),
              //     width: 100,
              //     height: 100,
              //   ),
              //   errorWidget: (context, url, error) => Icon(Icons.error),
              //   width: 100,
              //   height: 100,
              //   fit: BoxFit.cover,
              // ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.product.name)
                      .fontSize(15)
                      .fontWeight(FontWeight.w800),
                  Text("Category: ${widget.product.category.name}")
                      .fontSize(14)
                      .fontWeight(FontWeight.w600)
                      .color(Colors.green),
                  Text("Rs. ${widget.product.price}/set"),
                  Text("MOQ: ${widget.product.moq}"),
                ],
              ).paddingLeft(16),
            ),
            loading
                ? CircularProgressIndicator()
                    .container(width: 16, height: 16)
                    .paddingAll(8)
                : Column(
                    children: <Widget>[
                      Icon(
                        Icons.edit,
                        color: Theme.of(context).accentColor.withOpacity(0.5),
                      ).paddingAll(8).onClick(() {
                        Navigator.pushNamed(context, "add_product",
                            arguments: {"id": widget.product.id});
                      }),
                      if (widget.product.canDelete)
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                        ).paddingAll(8).onClick(() {
                          deleteProduct();
                        }),
                    ],
                  )
          ],
        ),
      ),
    ).onClick(() {
      Navigator.of(context)
          .pushNamed("product_detail", arguments: {"id": widget.product.id});
    });
  }

  void deleteProduct() async {
    _updateLoading(true);
    try {
      var pref = await SharedPreferences.getInstance();
      var token = pref.getString("token");
      var response = await dio.delete('product/${widget.product.id}',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      _updateLoading(false);
      if (response.statusCode == 200) {
        widget.callback();
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
