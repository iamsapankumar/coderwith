import 'package:badhat_b2b/ui/login/login_controller.dart';
import 'package:badhat_b2b/widgets/widget_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/extensions.dart';

class LoginView extends WidgetView<LoginScreen, LoginScreenState> {
  LoginView(LoginScreenState state) : super(state);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Form(
        key: state.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/badhat_logo.png",
              width: 80,
              height: 80,
            ).center(), SizedBox(
              height: 15,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) return "Enter Mobile number";
                if (value.length != 10) return "Enter 10 digit mobile number";
                return null;
              },
              keyboardType: TextInputType.numberWithOptions(signed: true),
              controller: state.username,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Mobile"),
            ).paddingAll(4),
         /*   TextFormField(
              validator: (value) {
                if (value.isEmpty) return "Enter valid password";
                return null;
              },
              controller: state.password,
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Password"),
            ).paddingAll(4),*/
           /* Text("Forgot Password?")
                .alignTo(Alignment.centerRight)
                .paddingTop(8)
                .onClick(() {
              Navigator.pushNamed(context, "forgot_password");
            }),*/
            if (state.loading)
              CircularProgressIndicator().container(height: 35).paddingAll(16)
            else
              Text("Send OTP")
                  .color(Colors.white)
                  .roundedBorder(
                    Theme.of(context).accentColor,
                    height: 44,
                  )
                  .onClick(() async{
               await state.requestOtp();
              }).paddingAll(16),
          /*  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Don't have an account?"),
                Text(" Register here")
                    .color(
                      Theme.of(context).accentColor,
                    )
                    .fontWeight(FontWeight.bold),
              ],
            ).paddingAll(24).onClick(() {
              Navigator.pushNamed(context, "register");
            })*/
          ],
        ).paddingAll(24),
      ),
    );
  }
}
