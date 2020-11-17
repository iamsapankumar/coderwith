import 'package:badhat_b2b/ui/otp/otp_controller.dart';
import 'package:badhat_b2b/widgets/widget_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import '../../utils/extensions.dart';

class OtpView extends WidgetView<OtpScreen, OtpScreenState> {
  OtpView(OtpScreenState state) : super(state);


  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                 Container(height: 60,color: Colors.deepOrange.withOpacity(0.4),
                  child: Column(children: [

                      Text("VERIFY DETAILS")
                          .fontSize(18)
                          .color(Colors.green)
                          .fontWeight(FontWeight.w800)
                          .alignTo(Alignment.centerLeft)
                          .paddingFromLTRB(10, 10, 10, 2),

                     Text("OTP sent to ${arguments['username']}")
                          .fontSize(10)
                          .color(Colors.green)
                          .fontWeight(FontWeight.w800)
                          .alignTo(Alignment.centerLeft)
                          .paddingFromLTRB(12,0,0,2)
               ],),
                ),

              Container(

                child: Image.asset(
                  "assets/images/badhat_logo.png",
                  width: 80,
                  height: 80,
                ).center(),
              ).alignTo(Alignment.center).paddingFromLTRB(70, 20, 70, 0),
              Text("Badhat")
                  .fontSize(12).color(Colors.black)
                  .fontWeight(FontWeight.w500)
                  .alignTo(Alignment.center),

              Card(
                shadowColor: Colors.green,
                elevation: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Text("Enter OTP")
                        .fontSize(12).color(Colors.black54)
                        .fontWeight(FontWeight.w500)
                        .paddingFromLTRB(35, 15, 16, 0)
                        .alignTo(Alignment.centerLeft),
                    PinEntryTextField(
                        isTextObscure: true,
                        showFieldAsBox: false,
                        fields: 4,
                        fieldWidth: 30.0,

                        onSubmit: (String pin){
                          state.submitOtp = pin;
                        } // end onSubmit
                    ).center(),
                    Row(
                      children: [
                        Text("Edit Mobile Number")
                            .fontSize(14).color(Colors.green)
                            .fontWeight(FontWeight.w500)
                            .paddingFromLTRB(10, 5, 2, 5)
                            .alignTo(Alignment.centerLeft).onClick(() {
                           Navigator.pop(context,arguments['username']);
                         }).paddingAll(24),
                        Visibility(
                          visible:state.counter>0,
                          child: Text(
                            '00:${state.counter}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.green
                            ),
                          ).paddingFromLTRB(20, 5, 0, 5)
                          .alignTo(Alignment.centerLeft)
                          .paddingAll(24),
                        ),
                        Visibility(
                          visible: state.counter==0,
                          child: Text("Resend OTP")
                              .fontSize(14).color(Colors.green)
                              .fontWeight(FontWeight.w500)
                              .paddingFromLTRB(0, 5, 0, 5)
                              .alignTo(Alignment.centerLeft)
                              .onClick(() async{
                            state.startTimer();
                            await state.resendOtp();
                          }).paddingAll(24),
                        ),

                      ],
                    ),
                    if (state.loading)
                      CircularProgressIndicator().container(height: 35).paddingAll(16)
                    else
                    Text("Submit OTP")
                        .fontWeight(FontWeight.bold)
                        .color(Colors.white)
                        .roundedBorder(
                      Colors.green,
                      height: 44,
                    )
                        .onClick(() async{
                      await state.checkUserStatus(state.submitOtp);
                    }).paddingFromLTRB(24, 5, 24, 24)
                  ],
                ),
              ).paddingFromLTRB(20, 20, 20, 120)
              .alignTo(Alignment.topCenter),

            ],
          ).paddingAll(0),
        ),
      ),
    );
  }
}