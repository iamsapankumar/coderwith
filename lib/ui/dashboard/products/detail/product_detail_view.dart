import 'package:badhat_b2b/ui/dashboard/products/detail/product_detail_controller.dart';
import 'package:badhat_b2b/widgets/full_screen_image.dart';
import 'package:badhat_b2b/widgets/widget_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';

import '../../../../main.dart';
import '../../../../utils/extensions.dart';

class ProductDetailView
    extends WidgetView<ProductDetailScreen, ProductDetailScreenState> {
  ProductDetailView(ProductDetailScreenState state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  child: Text("Product Detail")
                      .fontWeight(FontWeight.bold)
                      .fontSize(22)
                      .paddingLeft(8),
                ),
                Icon(
                  Icons.share,
                  size: 32,
                ).paddingAll(6).onClick(() async {
                  await Share.share(
                      "https://badhat.app/product/${state.product.id}");
                })
              ],
            ).paddingFromLTRB(8, 10, 8, 4),
            Divider(
              thickness: 1.1,
            ),
            state.loading
                ? CircularProgressIndicator()
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl: state.product.image,
                                
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return Container(
                                      color: Colors.grey.withOpacity(0.5));
                                },
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ).onClick(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FullScreenImageScreen(
                                              state.product.image)));
                            }),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(state.product.name)
                                    .fontSize(16)
                                    .fontWeight(FontWeight.w700),
                                Text("Rs. ${state.product.price} per ${state.product.moq} set")
                                    .paddingTop(6),
                              ],
                            ).paddingAll(8),
                          ],
                        ).paddingAll(8),
                        Divider(
                          thickness: 1.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Category ").fontWeight(FontWeight.w500),
                            Text("${state.product.subcategory.name}"),
                          ],
                        ).paddingAll(6),
                        if(state.product.vertical!=null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Subcategory ").fontWeight(FontWeight.w500),
                            Text("${state.product.vertical.name}"),
                          ],
                        ).paddingAll(6),
                        Divider(
                          thickness: 1.1,
                        ),
                        Text("Description")
                            .fontWeight(FontWeight.w500)
                            .paddingFromLTRB(8, 8, 0, 0),
                        Text(state.product.description??"N/A")
                            .paddingFromLTRB(8, 4, 0, 0),
                        if(state.product.userId!=userId)
                        FlatButton(
                          color: Colors.redAccent.withOpacity(0.3),
                          child: Text("Add to cart"),
                          onPressed: () {
                            addProductToCart(context);
                          },
                        )
                            .container(width: context.screenWidth())
                            .paddingAll(24),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void addProductToCart(BuildContext context) async {
    try {
      var response = await dio.post('addToCart',
          data: {
            "product_id": state.product.id,
            "quantity": state.product.moq,
            "vendor_id": state.product.userId,
          },
          options:
              Options(headers: {"Authorization": "Bearer ${state.token}"}));
      if (response.statusCode == 200) {
        cartCountController.add(response.data["data"]);
        showAlert(context, "Product added");
      }
    } on DioError catch (e) {}
  }
}
