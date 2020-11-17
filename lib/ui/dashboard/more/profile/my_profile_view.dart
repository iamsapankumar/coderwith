import 'package:badhat_b2b/ui/dashboard/more/profile/my_profile_controller.dart';
import 'package:badhat_b2b/widgets/widget_view.dart';
import 'package:flutter/material.dart';

import '../../../../utils/extensions.dart';

class MyProfileView extends WidgetView<MyProfileScreen, MyProfileScreenState> {
  MyProfileView(MyProfileScreenState state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                    child: Text("My Profile")
                        .fontWeight(FontWeight.bold)
                        .fontSize(22)
                        .paddingLeft(8),
                  )
                ],
              ).paddingFromLTRB(8, 10, 8, 4),
              Divider(
                thickness: 1.1,
              ),
              state.loading
                  ? CircularProgressIndicator()
                  : Form(
                      key: state.formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) return "Enter Business name";
                              return null;
                            },
                            textInputAction: TextInputAction.done,
                            controller: state.businessNameController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Business Name"),
                          ).paddingAll(4),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: state.gstinController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(), hintText: "GSTIN"),
                          ).paddingAll(4),

                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) return "Enter Owner name";
                              return null;
                            },
                            textInputAction: TextInputAction.done,
                            controller: state.ownerNameController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Owner Name"),
                          ).paddingAll(4),
                          TextFormField(
                            validator: (value) {
                              if (value.isNotEmpty && !value.validEmail())
                                return "Enter valid email";
                              return null;
                            },
                            textInputAction: TextInputAction.done,
                            controller: state.emailController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(), hintText: "Email"),
                          ).paddingAll(4),
                          TextFormField(
                            validator: (value) {
                              if (value.length != 10)
                                return "Enter 10 digit mobile number";
                              return null;
                            },
                            keyboardType:
                                TextInputType.numberWithOptions(signed: true),
                            controller: state.mobileController,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(), hintText: "Mobile"),
                          ).paddingAll(4),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: DropdownButtonFormField(
                                        validator: (value) {
                                          if (value == null)
                                            return "Select State";
                                          return null;
                                        },
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: "State"),
                                        onChanged: (stateName) {
                                          state.loadDistrict(stateName);
                                        },
                                        value: state.selectedState,
                                        items: state.states
                                            .map((e) => DropdownMenuItem(
                                                  value: e.state,
                                                  child: Text(
                                                    e.state.trim(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList())
                                    .paddingAll(4),
                              ),
                              Expanded(
                                child: DropdownButtonFormField(
                                  validator: (value) {
                                    if (value == null) return "Select District";
                                    return null;
                                  },
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "District"),
                                  onChanged: (district) {},
                                  value: state.selectedDistrict,
                                  items: state.districts
                                      .map((e) => DropdownMenuItem(
                                            child: Text(
                                              e,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            value: e,
                                          ))
                                      .toList(),
                                ).paddingAll(4),
                              )
                            ],
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: state.addressController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(), hintText: "Address"),
                          ).paddingAll(4),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: state.cityController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(), hintText: "City"),
                          ).paddingAll(4),
                          TextFormField(
                            validator: (value) {
                              if (value.length != 6)
                                return "Enter valid 6 digit pincode";
                              return null;
                            },
                            textInputAction: TextInputAction.done,
                            controller: state.pincodeController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Pincode"),
                          ).paddingAll(4),
                          if (state.saving)
                            CircularProgressIndicator()
                                .container(height: 35)
                                .paddingAll(16)
                          else
                            Text("Update")
                                .color(Colors.white)
                                .roundedBorder(
                                  Theme.of(context).accentColor,
                                  height: 44,
                                )
                                .paddingAll(16)
                                .onClick(() {
                                  state.updateProfile();
                            }),
                        ],
                      ),
                    )
            ],
          ).paddingAll(8),
        ),
      ),
    );
  }
}
