import 'package:badhat_b2b/utils/contants.dart';
import 'package:flutter/material.dart';

import '../../../../utils/extensions.dart';

class AboutScreen extends StatelessWidget {
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
                  child: Text("About")
                      .fontWeight(FontWeight.bold)
                      .fontSize(22)
                      .paddingLeft(8),
                )
              ],
            ).paddingFromLTRB(8, 10, 8, 4),
            Divider(
              thickness: 1.1,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Text(policies).fontSize(16).paddingAll(16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
