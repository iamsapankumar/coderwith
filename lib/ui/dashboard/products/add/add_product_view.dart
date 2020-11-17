import 'package:badhat_b2b/ui/dashboard/products/add/add_product_controller.dart';
import 'package:badhat_b2b/widgets/widget_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/extensions.dart';

class AddProductView
    extends WidgetView<AddProductScreen, AddProductScreenState> {
  AddProductView(AddProductScreenState state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text(state.id == null ? "Add New Product" : "Edit Product"),
      ),
      body: SingleChildScrollView(
        child: state.editLoading
            ? CircularProgressIndicator().center().paddingAll(16)
            : Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 180,
                    color: Colors.grey.withOpacity(0.2),
                    child: (state.product != null)
                        ? CachedNetworkImage(
                            imageUrl: state.product.image,
                          )
                        : state.productImage == null
                            ? Text("Add Product Image").center()
                            : Image.file(state.productImage),
                  ).onClick(() {
                    if (state.product == null) state.launchCamera();
                  }),
                  Form(
                    key: state.formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) return "Enter product name";
                            return null;
                          },
                          controller: state.productName,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: "Name"),
                        ).paddingAll(4),
                        TextFormField(
                          controller: state.productDescription,
                          textInputAction: TextInputAction.newline,
                          minLines: 3,
                          maxLines: 10,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Description"),
                        ).paddingAll(4),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty)
                              return "Enter minimum order quantity";
                            return null;
                          },
                          keyboardType:
                              TextInputType.numberWithOptions(signed: true),
                          controller: state.productMoq,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: "MOQ"),
                        ).paddingAll(4),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty)
                              return "Enter product price per set";
                            return null;
                          },
                          keyboardType:
                              TextInputType.numberWithOptions(signed: true),
                          controller: state.productPrice,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Price/Set"),
                        ).paddingAll(4),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: DropdownButtonFormField(
                                      validator: (value) {
                                        if (value == null)
                                          return "Select Category";
                                        return null;
                                      },
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Category"),
                                      onChanged: (category) {
                                        state.selectedSubCategory = category;
                                        state.loadVerticals();
                                      },
                                      value: state.selectedSubCategory,
                                      items: state.subCategories
                                          .map((e) => DropdownMenuItem(
                                                value: e.id,
                                                child: Text(
                                                  e.name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ))
                                          .toList())
                                  .paddingAll(4),
                            ),
                            Expanded(
                              child: DropdownButtonFormField(
                                      value: state.selectedVertical,
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Subcategory"),
                                      onChanged: (vertical) {
                                        state.setSelectedVertical(vertical);
                                      },
                                      items: state.verticals
                                          .map((e) => DropdownMenuItem(
                                                value: e.id,
                                                child: Text(
                                                  e.name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ))
                                          .toList())
                                  .paddingAll(4),
                            ),
                          ],
                        ),
                        if (state.loading)
                          CircularProgressIndicator()
                              .container(height: 35)
                              .paddingAll(16)
                        else
                          Text("Save")
                              .color(Colors.white)
                              .roundedBorder(
                                Theme.of(context).accentColor,
                                height: 44,
                              )
                              .paddingAll(16)
                              .onClick(() {
                            if (state.product == null)
                              state.requestAddProductApi();
                            else
                              state.requestEditProductApi();
                          }),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
