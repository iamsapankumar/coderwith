import 'package:badhat_b2b/ui/dashboard/search/search_controller.dart';
import 'package:badhat_b2b/utils/contants.dart';
import 'package:badhat_b2b/widgets/widget_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../utils/extensions.dart';

class SearchView extends WidgetView<SearchController, SearchControllerState> {
  SearchView(SearchControllerState state) : super(state);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.keyboard_arrow_left,
                  size: 32,
                ).paddingRight(4).onClick(() {
                  Navigator.pop(context, {});
                }),
                Expanded(
                  child: TextField(
                    controller: state.searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.fromLTRB(8, 6, 8, 18),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ).roundedStroke(Colors.grey.withOpacity(0.5),  40),
                ),
                Column(
                  children: [
                    Icon(
                      Icons.filter_list,
                      size: 32,
                    ).onClick(() {
                      state.showFilterSheet();
                    }),
                    Text("Filter")
                        .fontSize(10)
                        .alignTo(Alignment.center)
                  ],
                ),
                Text("Search")
                    .color(Colors.white)
                    .fontSize(10)
                    .roundedBorder(Theme.of(context).accentColor,
                        height: 40, width: 60)
                    .onClick(() {
                  state.doSearch();
                }).paddingLeft(8)
              ],
            ).paddingFromLTRB(8, 10, 4, 4),
            Divider(
              thickness: 1.5,
            ),
            Expanded(
              child: state.loading
                  ? CircularProgressIndicator().center()
                  : ListView.separated(
                      itemBuilder: (context, position) {
                        var data = state.searchResults[position];
                        return Row(
                          children: <Widget>[
                            (data.image == null || data.image.isEmpty)
                                ? Image.asset(
                              "assets/images/no-image.jpg", width: 60, height: 60,)
                                :
                            ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl: data.image ?? "",
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(data.businessType)
                                          .fontSize(10)
                                          .color(Colors.white)
                                          .paddingAll(4)
                                          .roundedBorder(
                                              Colors.purple.withOpacity(0.7),
                                              cornerRadius: 4),
                                      Text(data.businessCategory)
                                          .fontSize(10)
                                          .color(Colors.white)
                                          .paddingAll(4)
                                          .roundedBorder(
                                              Colors.pink.withOpacity(0.7),
                                              cornerRadius: 4)
                                          .paddingLeft(4),
                                    ],
                                    mainAxisSize: MainAxisSize.min,
                                  ),
                                  Text(data.businessName)
                                      .fontWeight(FontWeight.bold)
                                      .paddingTop(4),
                                  Row(
                                    children: [
                                      Visibility(
                                        visible:(data.name!=null),
                                        child: Text("${data.name}, ${data.district}")
                                            .paddingTop(4),
                                      ),
                                      Visibility(
                                        visible:(data.name!=null),
                                        child: Text(",")
                                            .paddingTop(4),
                                      ),
                                      Text(" ${data.district}")
                                          .paddingTop(4),
                                    ],
                                  ),
                                ],
                              ).paddingFromLTRB(12, 0, 8, 0),
                            ),
                            Icon(Icons.arrow_right),
                          ],
                        ).onClick(() {
                          Navigator.pushNamed(context, "vendor_profile",
                              arguments: {
                                "user_id": data.id,
                              });
                        }).paddingFromLTRB(16, 4, 16, 4);
                      },
                      separatorBuilder: (context, position) {
                        return Divider(
                          indent: 90,
                          thickness: 1.2,
                        );
                      },
                      itemCount: state.searchResults.length),
            )
          ],
        ),
      ),
    );
  }
}
