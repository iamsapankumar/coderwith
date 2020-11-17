import 'package:badhat_b2b/ui/register/register_controller.dart';
import 'package:badhat_b2b/utils/contants.dart';
import 'package:badhat_b2b/widgets/widget_view.dart';
import 'package:flutter/material.dart';

import '../../utils/extensions.dart';

class RegisterView extends WidgetView<RegisterScreen, RegisterScreenState> {
  RegisterView(RegisterScreenState state) : super(state);

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: state.formKey,
          child: Column(
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                child: Stack(
                  children: <Widget>[
                    ClipOval(
                      child: state.avatar == null
                          ? CircleAvatar(
                              backgroundColor: Colors.grey.withOpacity(0.5),
                            )
                          : Image.file(
                              state.avatar,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                    ).container(width: 80, height: 80),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ).paddingFromLTRB(0, 0, 4, 4),
                  ],
                ),
              ).paddingAll(24).onClick(() {
                state.launchImagePicker();
              }),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) return "Enter Business name";
                  return null;
                },
                textInputAction: TextInputAction.done,
                controller: state.businessNameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Shop/Business Name"),
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
                    border: OutlineInputBorder(), hintText: "Owner Name"),
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
                enabled: false,
                validator: (value) {
                  if (value.length != 10) return "Enter 10 digit mobile number";
                  return null;
                },
                keyboardType: TextInputType.numberWithOptions(signed: true),
                controller:TextEditingController(text: arguments['mobile']),
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Mobile"),
              ).paddingAll(4),
            /*  TextFormField(
                validator: (value) {
                  if (value.isEmpty) return "Enter Password";
                  return null;
                },
                textInputAction: TextInputAction.done,
                controller: state.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Password"),
              ).paddingAll(4),*/
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
              Row(
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonFormField(
                            validator: (value) {
                              if (value == null) return "Select State";
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
                                        overflow: TextOverflow.ellipsis,
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
                          border: OutlineInputBorder(), hintText: "District"),
                      onChanged: (district) {
                        state.updateSelectedDistrict(district);
                      },
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

              DropdownButtonFormField(
                      validator: (value) {
                        if (value == null) return "Select Business type";
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: "You are a "),
                      onChanged: (x) {
                        state.selectedBusinessType = x;
                      },
                      items: userType
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList())
                  .paddingAll(4),
              TextFormField(
                validator: (value) {
                  if (value.length != 6) return "Enter valid 6 digit pincode";
                  return null;
                },
                keyboardType: TextInputType.numberWithOptions(signed: true),
                textInputAction: TextInputAction.done,
                controller: state.pincodeController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Pincode"),
              ).paddingAll(4),
              DropdownButtonFormField(
                validator: (value) {
                  if (value == null) return "Select Business Domain";
                  return null;
                },
                isExpanded: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Business Domain"),
                onChanged: (category) {
                  state.selectedCategory = category;
                },
                value: state.selectedCategory,
                items: state.categories
                    .map((e) => DropdownMenuItem(
                          child: Text(
                            e.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: e.id.toString(),
                        ))
                    .toList(),
              ).paddingAll(4),
              if (state.loading)
                CircularProgressIndicator().container(height: 35).paddingAll(16)
              else
                Text("Register")
                    .color(Colors.white)
                    .roundedBorder(
                      Theme.of(context).accentColor,
                      height: 44,
                    )
                    .paddingAll(16)
                    .onClick(() {
                  state.registerUser();
                }),
          /*    Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?"),
                  Text(" Login")
                ],
              ).onClick(() {
                Navigator.pushNamed(context, "login");
              })*/
            ],
          ).paddingAll(24),
        ),
      ),
    );
  }
}
