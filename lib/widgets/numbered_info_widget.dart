import 'package:badhat_b2b/widgets/rounded_number_widget.dart';
import 'package:flutter/material.dart';

class NumberedInfoWidget extends StatelessWidget {
  final List<String> infoTextList;

  const NumberedInfoWidget(this.infoTextList, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        itemCount: infoTextList.length,
        itemBuilder: (context, position) {
          return ListTile(
            title: Text(infoTextList[position]),
            leading: RoundedNumberWidget(
              number: position + 1,
            ),
          );
        },
      ),
    );
  }
}
