import 'dart:convert';

import 'package:badhat_b2b/data/user_detail_response_entity.dart';
import 'package:badhat_b2b/generated/json/user_detail_response_entity_helper.dart';
import 'package:badhat_b2b/ui/dashboard/more/profile/my_profile_view.dart';
import 'package:badhat_b2b/utils/contants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/category_entity.dart';
import '../../../../data/state_district_model_entity.dart';
import '../../../../generated/json/state_district_model_entity_helper.dart';
import '../../../../main.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  MyProfileScreenState createState() => MyProfileScreenState();
}

class MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) => MyProfileView(this);

  // variables
  List<StateDistrictModelState> states = List();
  List<String> districts = List();
  List<CategoryData> categories = List();
  var businessNameController = TextEditingController();
  var ownerNameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var pincodeController = TextEditingController();
  var gstinController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();

  String selectedState, selectedDistrict, selectedCategory;

  var userType = [
    "Retailer",
    "Distributor",
    "Stockist",
    "Manufacturer",
    "Agent",
    "Brand",
    "Supplier"
  ];
  UserDetailResponseData profileData;
  bool loading = true;
  bool saving = false;
  String token;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    StateDistrictModelEntity entity = StateDistrictModelEntity();
    stateDistrictModelEntityFromJson(entity, jsonDecode(stateDistrict));
    states.addAll(entity.states);
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (profileData == null) {
      var pref = await SharedPreferences.getInstance();
      token = pref.getString("token");
      requestUserProfileApi();
    }

    super.didChangeDependencies();
  }

  void requestUserProfileApi() async {
    _updateLoading(true);
    try {
      var response = await dio.get('userProfile',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      profileData = UserDetailResponseData();
      userDetailResponseDataFromJson(profileData, response.data["data"]);
      populateData();
    } on DioError catch (e) {
      _updateLoading(false);
    }
  }

  void _updateLoading(bool value) {
    if (!mounted) return;
    setState(() {
      loading = value;
    });
  }

  void loadDistrict(String stateName) {
    setState(() {
      updateSelectedState(stateName);
      int stateIndex =
          states.indexWhere((element) => element.state == stateName);
      districts.clear();
      districts.addAll(states[stateIndex].districts);
      updateSelectedDistrict(districts[0]);
    });
  }

  void updateSelectedState(String state) {
    selectedState = state;
  }

  void updateSelectedDistrict(String district) {
//    print("distr:" + district);
    selectedDistrict = district;
  }

  void populateData() {
    print(jsonEncode(profileData));
    businessNameController.text = profileData.businessName;
    ownerNameController.text = profileData.name;
    mobileController.text = profileData.mobile;
    pincodeController.text = profileData.pincode;
    emailController.text = profileData.email;
    gstinController.text = profileData.gstin;
    addressController.text = profileData.address;
    cityController.text = profileData.city;
    selectedState = profileData.state;
    loadDistrict(selectedState);
    selectedDistrict = profileData.district;

    _updateLoading(false);
  }

  void updateProfile() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    } else {
      return;
    }

    if (!mounted) return;
    setState(() {
      saving = true;
    });

    var data = {
      "id": profileData.id,
      "name": ownerNameController.text,
      "business_name": businessNameController.text,
      "mobile": mobileController.text,
      "email": emailController.text,
      "state": selectedState,
      "district": selectedDistrict,
      "gstin": gstinController.text.toUpperCase(),
      "pincode": pincodeController.text,
      "address": addressController.text,
      "city": cityController.text,
    };

    try {
      var response = await dio.post(
        'updateProfile',
        data: data,
          options: Options(headers: {"Authorization": "Bearer $token"})
      );
      Navigator.pop(context);
    } on DioError catch (e) {
      if (!mounted) return;
      setState(() {
        saving = false;
      });
      showAlert(context, e.response.data["message"]);
    }
  }
}
