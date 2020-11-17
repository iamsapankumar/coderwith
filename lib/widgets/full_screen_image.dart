import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/extensions.dart';

class FullScreenImageScreen extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageScreen(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.keyboard_arrow_left,
                  size: 32,
                ).paddingRight(4).onClick(() {
                  Navigator.pop(context, {});
                }),
              ],
            ).paddingFromLTRB(8, 10, 8, 4),
            Divider(
              thickness: 1.5,
            ),
            Expanded(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: context.screenWidth(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
