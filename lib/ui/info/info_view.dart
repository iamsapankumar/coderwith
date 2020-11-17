import 'package:badhat_b2b/ui/info/info_controller.dart';
import 'package:badhat_b2b/widgets/numbered_info_widget.dart';
import 'package:badhat_b2b/widgets/widget_view.dart';
import 'package:flutter/material.dart';

import '../../utils/extensions.dart';

class InfoView extends WidgetView<InfoScreen, InfoScreenState> {
  InfoView(InfoScreenState state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Image.asset(
              "assets/images/badhat_logo.png",
              width: 80,
              height: 80,
            ).center(),
            Text("Why use Badhat?")
                .fontSize(20)
                .fontWeight(FontWeight.w500)
                .paddingFromLTRB(0, 16, 16, 8)
                .alignTo(Alignment.centerLeft),
            Text("Retailers & Shops can: ")
                .fontSize(18)
                .fontWeight(FontWeight.w500)
                .paddingFromLTRB(0, 24, 16, 16)
                .alignTo(Alignment.centerLeft),
            Text("1. Order from their personal wholesalers in seconds").fontSize(16).paddingAll(1.5),
            Text("2. Discover products").fontSize(16).paddingAll(1.5),
            Text("3. Bookmark all personal suppliers at one place").fontSize(16).paddingAll(1.5),
            Text("Suppliers can: ")
                .fontSize(18)
                .fontWeight(FontWeight.w500)
                .paddingFromLTRB(0, 24, 16, 16)
                .alignTo(Alignment.centerLeft),
            Text("1. Get High Profit as No commission & no charges").fontSize(16).paddingAll(1.5),
            Text("2. Show their products to customers").fontSize(16).paddingAll(1.5),
            Text("3. Manage order without any hassle").fontSize(16).paddingAll(1.5),
            Text("3. Bookmark all personal retailers & shops").fontSize(16).paddingAll(1.5),
            Text("Let's get started!").fontWeight(FontWeight.bold)
                .color(Colors.white)
                .roundedBorder(
                  Colors.blue,
                  height: 44,
                )
                .onClick(() {
              Navigator.pushNamed(context, "login");
            }).paddingAll(24),
          ],
        ).paddingAll(16),
      ),
    );
  }
}
