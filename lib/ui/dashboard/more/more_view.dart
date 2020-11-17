import 'package:badhat_b2b/main.dart';
import 'package:badhat_b2b/ui/dashboard/more/more_controller.dart';
import 'package:badhat_b2b/widgets/app_bar.dart';
import 'package:badhat_b2b/widgets/widget_view.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/extensions.dart';

class MoreView extends WidgetView<MoreScreen, MoreScreenState> {
  MoreView(MoreScreenState state) : super(state);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              MyAppBar("More").paddingAll(10),
              Divider(
                thickness: 1.1,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.menuItems.length,
                  separatorBuilder: (context, position) {
                    return Divider();
                  },
                  itemBuilder: (context, position) {
                    var item = state.menuItems[position];
                    return Row(
                      children: <Widget>[
                        Expanded(child: Text(item).paddingLeft(16)),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                      ],
                    ).paddingFromLTRB(16, 8, 16, 8).onClick(() async {
                      switch (position) {
                        case 0:
                          Navigator.pushNamed(context, "my_profile");
                          break;
                        case 1:
                          Navigator.pushNamed(context, "vendor_profile",
                              arguments: {
                                "user_id": userId,
                              });
                          break;
                        case 2:
                          Navigator.pushNamed(context, "about");
                          break;
                        case 3:
                          Navigator.pushNamed(context, "policies");
                          break;
                        case 4:
                          Navigator.pushNamed(context, "how_to");
                          break;
                        case 5:
                          state.navigateToAdminChat();
                          break;
                        default:
                      }
                    });
                  }),
              if(userId!=1)
              Text("Share your profile")
                  .color(Colors.white)
                  .roundedBorder(
                    Theme.of(context).accentColor,
                    height: 44,
                    width: context.screenWidth() * 0.5,
                  )
                  .paddingAll(24)
                  .onClick(() async {
                await Share.share("https://badhat.app/user/${userId}");
              }),
              Text("Logout")
                  .color(Colors.white)
                  .roundedBorder(
                    Theme.of(context).accentColor,
                    height: 44,
                    width: context.screenWidth() * 0.5,
                  )
                  .paddingAll(24)
                  .onClick(() async {
                await state.logout();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
