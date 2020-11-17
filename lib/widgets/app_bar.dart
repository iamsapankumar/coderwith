import 'package:badhat_b2b/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/extensions.dart';

class MyAppBar extends StatefulWidget {
  final String title;
  final bool showSearchBar;

  const MyAppBar(this.title, {this.showSearchBar}) : super();

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(widget.title).fontSize(16).fontWeight(FontWeight.bold),
        if (widget.showSearchBar != null)
          Expanded(
            child: Row(
              children: <Widget>[
                Icon(Icons.search).paddingFromLTRB(6, 0, 4, 0),
                Flexible(
                    child: Text(
                  "Search Suppliers & retailers",
                  overflow: TextOverflow.ellipsis,
                ).fontSize(13)),
              ],
            )
                .roundedStroke(Colors.grey.withOpacity(0.5), 38)
                .paddingLeft(8)
                .onClick(() {
              Navigator.of(context).pushNamed("search");
            }),
          ),
        Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Icon(
                  Icons.notifications,
                  size: 28,
                  color: Theme.of(context).accentColor,
                ).paddingAll(3),
                StreamBuilder<int>(
                    stream: notificationCountController,
                    builder: (context, snapshot) {
                      return Positioned(
                        top: 0,
                        right: 1,
                        child: (snapshot.data == null || snapshot.data == 0)
                            ? Container()
                            : CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.orange,
                                child: Text(snapshot.data.toString())
                                    .fontSize(11)
                                    .color(Colors.white),
                              ),
                      );
                    })
              ],
            ).onClick(() {
              Navigator.of(context).pushNamed("notifications");
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
                        child: (snapshot.data == null || snapshot.data == 0)
                            ? Container()
                            : CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.orange,
                                child: Text(snapshot.data.toString())
                                    .fontSize(11)
                                    .color(Colors.white)),
                      );
                    })
              ],
            ).onClick(() {
              Navigator.pushNamed(context, "cart");
            }),
          ],
        )
      ],
    );
  }
}
