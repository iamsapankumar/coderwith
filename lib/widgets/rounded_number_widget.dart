import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RoundedNumberWidget extends StatelessWidget {
  final int number;

  const RoundedNumberWidget({Key key, this.number}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("$number"),
      decoration: ShapeDecoration(
        color: Colors.black87,
        shape: CircleBorder(
          side: BorderSide(width: 5,)
        ),
      ),
    );
  }
}
