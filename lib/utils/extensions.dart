import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  Size screenSize() {
    return MediaQuery.of(this).size;
  }
  double screenWidth(){
    return this.screenSize().width;
  }
}

extension TextFieldExt on TextField {
  TextField noInputBorder() {
    return TextField(
        decoration: this.decoration == null
            ? InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
              )
            : this.decoration.copyWith(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
                ));
  }

  TextField addHint(String hintText) {
    return TextField(
        decoration: this.decoration == null
            ? InputDecoration(hintText: hintText)
            : this.decoration.copyWith(hintText: hintText));
  }
}

extension ContainerViewExt on Widget {
  Container roundedBorder(Color color,
      {double height, double width, double cornerRadius = 20.0}) {
    return Container(
      child: Center(child: this),
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(cornerRadius)),
    );
  }

  Container roundedStroke(Color color, double height,
      {double width, double cornerRadius = 20.0}) {
    return Container(
      child: this,
      height: height,
      width: width,
      decoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide()),
          borderRadius: BorderRadius.circular(cornerRadius)),
    );
  }
}

extension TextViewExt on Text {
  Text customFont(String fontFamily) {
    return Text(
      this.data,
      style: this.style != null
          ? this.style.copyWith(fontFamily: fontFamily)
          : TextStyle(fontFamily: fontFamily),
    );
  }

  Text fontWeight(FontWeight fontWeight) {
    return Text(
      this.data,
      style: this.style != null
          ? this.style.copyWith(fontWeight: fontWeight)
          : TextStyle(fontWeight: fontWeight),
    );
  }

  Text fontSize(double fontSize) {
    return Text(
      this.data,
      style: this.style != null
          ? this.style.copyWith(fontSize: fontSize)
          : TextStyle(fontSize: fontSize),
    );
  }

  Text underlined() {
    return Text(
      this.data,
      style: this.style != null
          ? this.style.copyWith(decoration: TextDecoration.underline)
          : TextStyle(decoration: TextDecoration.underline),
    );
  }

  Text color(Color color) {
    return Text(
      this.data,
      style: this.style != null
          ? this.style.copyWith(color: color)
          : TextStyle(color: color),
    );
  }
}

extension AlertsView on String {
  int getBackgroundType() {
    if (this.contains("ON") || this.contains("Re-connect"))
      return 2; //green
    else {
      return 1; //red
    }
  }
}

extension UtilExtension on String {
  bool notEmpty() {
    return this != null && this.isNotEmpty;
  }

  bool validEmail() {
    return this.notEmpty() && this.contains('@');
  }

  bool validPhone() {
    return this.notEmpty() && this.length == 10;
  }
}

extension WidgetExt on Widget {
  Widget alignTo(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  Widget onClick(VoidCallback callback) {
    return InkWell(
      child: this,
      onTap: () => callback(),
    );
  }

  Container container({double height, double width}) {
    return Container(
      child: this,
      height: height,
      width: width,
    );
  }

  Widget center() {
    return Center(
      child: this,
    );
  }
}

extension WidgetPadding on Widget {
  Widget paddingTop(double padding) =>
      Padding(padding: EdgeInsets.only(top: padding), child: this);

  Widget paddingLeft(double padding) =>
      Padding(padding: EdgeInsets.only(left: padding), child: this);

  Widget paddingRight(double padding) =>
      Padding(padding: EdgeInsets.only(right: padding), child: this);

  Widget paddingAll(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);

  Widget paddingFromLTRB(
          double left, double top, double right, double bottom) =>
      Padding(
          padding: EdgeInsets.fromLTRB(left, top, right, bottom), child: this);
}
