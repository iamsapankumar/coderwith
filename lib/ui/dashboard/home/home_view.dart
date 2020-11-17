import 'package:badhat_b2b/ui/dashboard/home/home_controller.dart';
import 'package:badhat_b2b/widgets/app_bar.dart';
import 'package:badhat_b2b/widgets/widget_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../data/chat_room_response_entity.dart';
import '../../../utils/extensions.dart';

class HomeView extends WidgetView<HomeScreen, HomeScreenState> {
  HomeView(HomeScreenState state) : super(state);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: Text("info").fontSize(18),
          icon: Icon(FontAwesomeIcons.info,size: 14,),

          onPressed: ()  {
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyAppBar(
              "Badhat",
              showSearchBar: true,
            ).paddingFromLTRB(10, 10, 10, 4),
            Divider(
              thickness: 1.1,
            ),
            Text("Liked Stores")
                .fontWeight(FontWeight.bold)
                .fontSize(20)
                .paddingFromLTRB(10, 10, 0, 16),
            Expanded(
              child: loading
                  ? CircularProgressIndicator().center()
                  : favorites.length == 0
                      ? Text("Add businesses to favorite to view over here.")
                          .center()
                      : RefreshIndicator(
                          onRefresh: () async {
                            state.requestFavoritesApi();
                          },
                          child: ListView.separated(
                              itemCount: favorites.length,
                              padding: const EdgeInsets.all(0),
                              separatorBuilder: (context, position) {
                                return Divider(
                                  indent: 90,
                                  thickness: 1,
                                );
                              },
                              itemBuilder: (context, position) {
                                var data = favorites[position].vendor;
                                return Visibility(
                                  visible: data != null,
                                  child: Row(
                                    children: <Widget>[
                                      ClipRRect(
                                        child: (data == null || (data.image == null || data.image.isEmpty))
                                            ? Image.asset(
                                                "assets/images/no-image.jpg", width: 60, height: 60,)
                                            : CachedNetworkImage(
                                                imageUrl: data.image ?? "",
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                              ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(data == null ? "" : data.businessType)
                                                    .fontSize(10)
                                                    .color(Colors.white)
                                                    .paddingAll(4)
                                                    .roundedBorder(
                                                        Colors.purple
                                                            .withOpacity(0.7),
                                                        cornerRadius: 4),
                                                Text(data == null ? "" : data.businessCategory)
                                                    .fontSize(10)
                                                    .color(Colors.white)
                                                    .paddingAll(4)
                                                    .roundedBorder(
                                                        Colors.pink
                                                            .withOpacity(0.7),
                                                        cornerRadius: 4)
                                                    .paddingLeft(4),
                                              ],
                                              mainAxisSize: MainAxisSize.min,
                                            ),
                                            Text(data == null ? "" : data.businessName)
                                                .fontWeight(FontWeight.bold)
                                                .paddingTop(4),
                                            Visibility(
                                              visible: (data != null ),
                                              child: Text("${data == null ? "" : data.name}, ${data == null ? "" : data.district}")
                                                  .paddingTop(4),
                                            ),
                                          ],
                                        ).paddingFromLTRB(12, 0, 8, 0),
                                      ),
                                      Icon(Icons.chat).onClick(() {
                                        ChatRoomResponseDataVendor d =
                                            ChatRoomResponseDataVendor(
                                                id: data == null ? "" : data.id,
                                                name: data == null ? "" : data.name,
                                                businessName: data == null ? "" : data.businessName,
                                                image: data == null ? "" : data.image,
                                                roomId:data == null ?  "" : data.roomId);

//                                  print(data.roomId);
                                        Navigator.pushNamed(context, "chat",
                                            arguments: {
                                              "vendor": (d),
                                            });
                                      }),
                                    ],
                                  ).onClick(() {
                                    Navigator.pushNamed(context, "vendor_profile",
                                        arguments: {
                                          "user_id": data == null ? "" : data.id,
                                        });
                                  }).paddingFromLTRB(16, 4, 16, 4),
                                );
                              }),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
