import 'dart:convert';
import 'dart:io';

import 'package:badhat_b2b/main.dart';
import 'package:badhat_b2b/ui/register/register_view.dart';
import 'package:badhat_b2b/utils/contants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/category_entity.dart';
import '../../data/state_district_model_entity.dart';
import '../../generated/json/category_entity_helper.dart';
import '../../generated/json/state_district_model_entity_helper.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) => RegisterView(this);

  // variables
  List<StateDistrictModelState> states = List();
  List<String> districts = List();
  List<CategoryData> categories = List();
  String selectedState,
      selectedDistrict,
      selectedBusinessType,
      selectedCategory;
  TextEditingController businessNameController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController gstinController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  /*TextEditingController passwordController = TextEditingController();*/
  TextEditingController pincodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  File avatar;
  final picker = ImagePicker();
  bool loading = false;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    _fetchCategories();
    StateDistrictModelEntity entity = StateDistrictModelEntity();
    stateDistrictModelEntityFromJson(entity, jsonDecode(stateDistrict));
    states.addAll(entity.states);
    super.initState();
  }

  void loadDistrict(String stateName) {
    setState(() {
      updateSelectedState(stateName);
      int stateIndex =
          states.indexWhere((element) => element.state == stateName);
      districts.clear();
      districts.addAll(states[stateIndex].districts);
      updateSelectedDistrict(districts[0]);
      print(jsonEncode(districts));
    });
  }

  void updateSelectedState(String state) {
    selectedState = state;
  }

  void updateSelectedDistrict(String district) {
//    print("distr:" + district);
    selectedDistrict = district;
  }

  void _fetchCategories() {
    dio
        .get(
      'categories',
    )
        .catchError((e) {
      updateLoading(false);
    }).then((response) {
      updateLoading(false);
      if (response.statusCode == 200) {
        CategoryEntity entity = CategoryEntity();
        categoryEntityFromJson(entity, response.data);
        setState(() {
          categories = entity.data;
        });
      } else {}
    }).catchError((e) {});
  }

  void registerUser() async {
//    if (avatar == null) {
//      showAlert(context, "Please add a business image or logo");
//      return;
//    }
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    } else {
      return;
    }
    updateLoading(true);
    var pref = await SharedPreferences.getInstance();

    FormData data = FormData.fromMap({
      "name": ownerNameController.text,
      "business_name": businessNameController.text,
      "email": emailController.text,
      "gstin": gstinController.text.toUpperCase(),
      "mobile": pref.getString("UserName"),
      /*"password": passwordController.text,*/
      "state": selectedState,
      "district": selectedDistrict,
      "business_type": selectedBusinessType,
      "business_category": selectedCategory,
      "latitude": "11",
      "longitude": "12",
      "pincode": pincodeController.text,
      "address": addressController.text,
      "city": cityController.text,
      "image":
          (avatar == null) ? null : await MultipartFile.fromFile(avatar.path),
    });


    try {
      var response = await dio.post(
        'register',
        data: data,
      );
      updateLoading(false);
      /*Navigator.pop(context);*/
      Navigator.pushNamed(context, "dashboard");
    } on DioError catch (e) {
      updateLoading(false);
      showAlert(context, e.response.data["message"]);
    }
  }

  void launchImagePicker() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    final croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    setState(() {
      avatar = File(croppedFile.path);
    });
  }

  void updateLoading(bool value) {
    if (!mounted) return;
    setState(() {
      loading = value;
    });
  }
}
