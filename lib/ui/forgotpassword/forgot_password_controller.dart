import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/extensions.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController mobileController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Forgot Password?").fontWeight(FontWeight.bold).fontSize(32),
            Text("A new password will be sent to your registered mobile number.")
                .paddingTop(8),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) return "Enter Mobile number";
                if (value.length != 10) return "Enter 10 digit mobile number";
                return null;
              },
              keyboardType: TextInputType.numberWithOptions(signed: true),
              controller: mobileController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Mobile"),
            ).paddingTop(12),
            if (loading)
              CircularProgressIndicator().container(height: 35).paddingAll(16)
            else
              Text("Submit")
                  .color(Colors.white)
                  .roundedBorder(
                    Theme.of(context).accentColor,
                    height: 44,
                  )
                  .onClick(() {
                requestApi();
              }).paddingAll(16),
          ],
        ),
      ).paddingAll(24),
    );
  }

  void requestApi() async {


    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();

    if (!mounted) return;
    setState(() {
      loading = true;
    });

    try {
      var response = await dio.post(dio.options.baseUrl + 'forgotPassword', data: {
        "mobile": mobileController.text,
      });

      var x= await showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("Alert"),
          content: Text(response.data["message"]),
          actions: <Widget>[
            RaisedButton(
              child: Text("Okay"),
              onPressed: (){
                Navigator.pop(context,{});
              },
            )
          ],
        );
      });
      if(x!=null){
        Navigator.pop(context);
      }

      if (!mounted) return;
      setState(() {
        loading = false;
      });

    } on DioError catch (e) {

      if (!mounted) return;
      setState(() {
        loading = false;
      });
      showAlert(context, e.response.data["message"]);
    }
  }
}
