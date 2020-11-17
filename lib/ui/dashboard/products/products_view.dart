import 'package:badhat_b2b/ui/dashboard/products/product_item_view.dart';
import 'package:badhat_b2b/ui/dashboard/products/products_controller.dart';
import 'package:badhat_b2b/widgets/app_bar.dart';
import 'package:badhat_b2b/widgets/widget_view.dart';
import 'package:flutter/material.dart';

import '../../../utils/extensions.dart';

class ProductsView extends WidgetView<ProductsScreen, ProductsScreenState> {
  ProductsView(ProductsScreenState state) : super(state);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Add Product"),
          icon: Icon(Icons.add),

          onPressed: () async {
            var x = await Navigator.pushNamed(context, "add_product");
            if (x != null) {
              state.loadProducts();
            }
          },
        ),
        body: Column(
          children: <Widget>[
           MyAppBar("Products").paddingFromLTRB(10, 10, 10, 4),
            Divider(
              thickness: 1.1,
            ),
            Expanded(
              child: loading
                  ? CircularProgressIndicator().center()
                  : ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        var product = products[index];
                        return ProductItemView(
                          product: product,
                          callback: (){
                            state.loadProducts();
                          },
                          key: Key(index.toString()),
                        );
                      }),
            )
          ],
        ),
      ),
    );
  }
}
