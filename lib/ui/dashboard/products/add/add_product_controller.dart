import 'dart:io';

import 'package:badhat_b2b/generated/json/subcategoryresponse_entity_helper.dart';
import 'package:badhat_b2b/main.dart';
import 'package:badhat_b2b/ui/dashboard/products/add/add_product_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/product_detail_entity.dart';
import '../../../../data/subcategoryresponse_entity.dart';
import '../../../../generated/json/product_detail_entity_helper.dart';
import '../../../../generated/json/subcategoryresponse_entity_helper.dart';

class AddProductScreen extends StatefulWidget {
  @override
  AddProductScreenState createState() => AddProductScreenState();
}

class AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) => AddProductView(this);

  // variable
  File productImage;
  TextEditingController productName = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController productMoq = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  int selectedSubCategory, selectedVertical;
  bool loading = false;
  bool editLoading = false;
  final formKey = GlobalKey<FormState>();
  List<SubcategoryResponseData> subCategories = List();
  List<SubcategoryVertical> verticals = List();
  final picker = ImagePicker();
  String token;
  ProductDetailData product;
  bool editMode;
  int id;

  @override
  void didChangeDependencies() {
    _fetchCategories();
    var arguments = ModalRoute.of(context).settings.arguments;
    if (arguments != null) {
      id = (arguments as Map)["id"];
      editLoading=true;
      Future.delayed(Duration(seconds: 2), () {
        requestProductDetailApi(id);
      });
    }

    super.didChangeDependencies();
  }

  void _fetchCategories() async {
    var pref = await SharedPreferences.getInstance();
    token = pref.getString("token");

    dio
        .get(
      'subCategories',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    )
        .catchError((e) {
      updateLoading(false);
    }).then((response) {
      updateLoading(false);
      if (response.statusCode == 200) {
        setState(() {
          SubcategoryResponseEntity entity = SubcategoryResponseEntity();
          subcategoryResponseEntityFromJson(entity, response.data);
          subCategories.addAll(entity.data);
        });
      } else {}
    }).catchError((e) {});
  }

  void updateLoading(bool value) {
    if(!mounted) return;
    setState(() {
      loading = value;
    });
  }

  void requestAddProductApi() async {
    if (productImage == null) {
      showAlert(context, "Add Product Image");
      return;
    }
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    } else {
      return;
    }

    var data = FormData.fromMap({
      "name": productName.text,
      "description": productDescription.text?? "",
      "moq": productMoq.text,
      "price": productPrice.text,
      "sub_category_id": selectedSubCategory,
      "vertical_id": selectedVertical,
      "image": await MultipartFile.fromFile(productImage.path),
    });

    updateLoading(true);
    try {
      var response = await dio.post(
        'addProduct',
        data: data,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      updateLoading(false);
      Navigator.pop(context, {});
    } on DioError catch (e) {
      updateLoading(false);
      showAlert(context, e.response.data["message"]);
    }
  }

  void requestEditProductApi() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    } else {
      return;
    }

    var data = FormData.fromMap({
      "id": product.id,
      "name": productName.text,
      "description": productDescription.text,
      "moq": productMoq.text,
      "price": productPrice.text,
      "sub_category_id": selectedSubCategory,
      "vertical_id": selectedVertical,
    });

    updateLoading(true);
    try {
      var response = await dio.post(
        'editProduct',
        data: data,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      updateLoading(false);
      Navigator.pop(context, {});
    } on DioError catch (e) {
      updateLoading(false);
      showAlert(context, e.response.data["message"]);
    }
  }

  void setSelectedVertical(int id) {
    if (!mounted) return;
    setState(() {
      selectedVertical = id;
    });
  }

  void loadVerticals() {
    if (!mounted) return;
    setState(() {
      verticals = subCategories[subCategories
              .indexWhere((element) => element.id == selectedSubCategory)]
          .verticals;
    });
  }

  void launchCamera() async {
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
      productImage = File(croppedFile.path);
    });
  }

  void requestProductDetailApi(id) async {

    var pref = await SharedPreferences.getInstance();
    token = pref.getString("token");
    dio
        .get(
      'product/$id}',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    )
        .catchError((e) {

    }).then((response) {
        ProductDetailEntity entity = ProductDetailEntity();
        productDetailEntityFromJson(entity, response.data);
        product = entity.data;
        editLoading=false;
        populateUI();

    }).catchError((e) {});
  }

  void populateUI() {
    productName.text = product.name;
    productDescription.text = product.description;
    productMoq.text = product.moq.toString();
    productPrice.text = product.price;
    selectedSubCategory = product.subCategoryId;
    loadVerticals();
    selectedVertical = product.verticalId;

    setState(() {});
  }
}
