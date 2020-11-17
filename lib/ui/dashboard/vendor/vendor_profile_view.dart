import 'package:badhat_b2b/data/chat_room_response_entity.dart';
import 'package:badhat_b2b/main.dart';
import 'package:badhat_b2b/ui/dashboard/vendor/product_item_view.dart';
import 'package:badhat_b2b/ui/dashboard/vendor/vendor_profile_controller.dart';
import 'package:badhat_b2b/widgets/widget_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../../utils/extensions.dart';

class VendorProfileView
    extends WidgetView<VendorProfileController, VendorProfileControllerState> {
  VendorProfileView(VendorProfileControllerState state) : super(state);

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
                  Navigator.pop(context);
                }),
                Stack(
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart,
                      size: 28,
                      color: Theme.of(context).accentColor,
                    ).paddingAll(3),
                    StreamBuilder<int>(
                        stream: cartCountController,
                        builder: (context, snapshot) {
                          return Positioned(
                            top: 0,
                            right: 1,
                            child:  (snapshot.data == null || snapshot.data == 0)
                              ? Container()
                              :  CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.orange,
                               child:Text(snapshot.data.toString())
                                    .fontSize(11)
                                    .color(Colors.white)),
                          );
                        })
                  ],
                ).onClick(() {
                  Navigator.pushNamed(context, "cart");
                }),
              ],
            ).paddingFromLTRB(8, 10, 8, 4),
            Divider(
              thickness: 1.2,
            ),
            Expanded(
              child: (state.loading)
                  ? CircularProgressIndicator().center()
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: (state.data.image == null || state.data.image.isEmpty)
                                    ? Image.asset(
                                  "assets/images/no-image.jpg", width: 60, height: 60,)
                                    : CachedNetworkImage(
                                  imageUrl: state.data.image ?? "",
                                  fit: BoxFit.cover,
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(state.data.businessType)
                                            .fontSize(10)
                                            .color(Colors.white).paddingAll(4)
                                            .roundedBorder(Colors.purple
                                            .withOpacity(0.7),cornerRadius: 4),
                                        Text(state.data.businessCategory)
                                            .fontSize(10)
                                            .color(Colors.white).paddingAll(4)
                                            .roundedBorder(Colors.pink
                                            .withOpacity(0.7),cornerRadius: 4).paddingLeft(4),


                                        /*ListView.builder(
                                            itemCount: state.data.subCategory.length,
                                            itemBuilder: (context, position){
                                              return Text(state.data.subCategory[position])
                                                  .fontSize(5)
                                                  .color(Colors.white).paddingAll(4)
                                                  .roundedBorder(Colors.pink
                                                  .withOpacity(0.7),cornerRadius: 4).paddingLeft(4);
                                            }),*/
                                      ],
                                      mainAxisSize: MainAxisSize.min,
                                    ),
                                    Text(state.data.businessName.toUpperCase())
                                        .fontWeight(FontWeight.bold)
                                        .fontSize(16).paddingTop(4),
                                    Visibility(
                                        visible:state.data.name != null,
                                        child: Text("Owner Name:  ${state.data.name}").paddingTop(2)),
                                    Text("${state.data.district}")
                                        .paddingTop(2),
                                    Text(
                                        "${state.data.state}")
                                  ],
                                ).paddingFromLTRB(16, 0, 16, 0),
                              ),
                            ],
                          ).paddingAll(24),
                          (state.data.id>=1000000001)?Visibility(
                            visible:(state.data.id>=1000000000)&&(state.data.subCategory.isNotEmpty || state.data.verticals.isNotEmpty),
                            child: SingleChildScrollView(
                              reverse: true,
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      height:20,
                                      constraints: BoxConstraints(maxHeight: 20,),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, position) {
                                            return Container(
                                              height:20,
                                              child: Text(
                                                "${state.data.subCategory[position]}",
                                              ).fontSize(10)
                                                  .color(Colors.black).paddingAll(4)
                                                  .roundedBorder(Colors.grey
                                                  .withOpacity(0.2),cornerRadius: 10).paddingLeft(4),
                                            );
                                          },
                                          itemCount: state.data.subCategory.length),
                                    ),
                                    SizedBox(height: 5,),
                                    Container(
                                      height:20,constraints: BoxConstraints(maxHeight: 20,),
                                      child: ListView.builder(

                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, position) {
                                            return Container(
                                              height:15,
                                              child: Text(
                                                "${state.data.verticals[position]}",
                                              ).fontSize(10)
                                                  .color(Colors.black).paddingAll(4)
                                                  .roundedBorder(Colors.grey
                                                  .withOpacity(0.2),cornerRadius: 10).paddingLeft(4),
                                            );
                                          },
                                          itemCount: state.data.verticals.length),
                                    ).paddingFromLTRB(0,0,6,0),
                                  ],
                                ),
                              ).paddingFromLTRB(5, 0, 5,0),
                            ).paddingFromLTRB(10,0,10,0),
                          ):Visibility(visible:(state.data.id<=1000000000), child:Text("")),

                          Divider(
                            thickness: 2,
                          ),
                          if (state.userId != userId)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Icon(
                                      state.data.favorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                      size: 28,
                                    ),
                                    Text("Favorite")
                                  ],
                                ).onClick(() {
                                  state.requestUpdateFavoriteApi();
                                }),
                                Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.share,
                                      size: 28,
                                    ),
                                    Text("Share")
                                  ],
                                ).onClick(() async {
                                  await Share.share(
                                      "https://badhat.app/user/${state.userId}");
                                }),
                                Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.chat,
                                      size: 28,
                                    ),
                                    Text("Chat")
                                  ],
                                ).onClick(() {
                                  ChatRoomResponseDataVendor d =
                                      ChatRoomResponseDataVendor(
                                          id: state.data.id,
                                          name: state.data.name,
                                          businessName: state.data.businessName,
                                          image: state.data.image,
                                          roomId: state.data.roomId);
                                  Navigator.pushNamed(context, "chat",
                                      arguments: {
                                        "vendor": (d),
                                      });
                                })
                              ],
                            ).paddingAll(4),
                          if (state.userId != userId)
                            Divider(
                              thickness: 2,
                            ),
//                          Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              Text("Owner Name:  ${state.data.name}")
//                                  .fontSize(15),
//                              Text("Category:  ${state.data.businessCategory}")
//                                  .fontSize(15)
//                                  .paddingTop(4),
//                              Text("Address:  ${state.data.address}")
//                                  .fontSize(15)
//                                  .paddingTop(4),
//                              Text("City:  ${state.data.city} - ${state.data.pincode}")
//                                  .fontSize(15)
//                                  .paddingTop(4),
//                            ],
//                          ).paddingAll(8),
//                          Divider(
//                            thickness: 2,
//                          ),
                          Text("Products")
                              .fontSize(24)
                              .fontWeight(FontWeight.w700)
                              .paddingAll(8)
                              .center(),
                          state.data.products.isEmpty
                              ? Container(
                                  height: 100,
                                  child: Text("No Products available").center())
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (context, position) {
                                    return VendorProductItem(
                                        state.data.products[position],
                                        state.userId == userId);
                                  },
                                  itemCount: state.data.products.length)
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
