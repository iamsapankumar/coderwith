import 'package:badhat_b2b/ui/dashboard/vendor/vendor_profile_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/user_detail_response_entity.dart';
import '../../../generated/json/user_detail_response_entity_helper.dart';
import '../../../main.dart';

class VendorProfileController extends StatefulWidget {
  @override
  VendorProfileControllerState createState() => VendorProfileControllerState();
}

class VendorProfileControllerState extends State<VendorProfileController> {
  @override
  Widget build(BuildContext context) => VendorProfileView(this);
  // variables
  Map arguments;
  int userId;
  bool loading = true;
  UserDetailResponseData data;

  @override
  void didChangeDependencies() async {
    arguments = ModalRoute.of(context).settings.arguments;
    userId = arguments["user_id"];
    if (data == null) requestUserProfileApi();
    super.didChangeDependencies();
  }

  void requestUserProfileApi() async {
    _updateLoading(true);
    try {
      var response = await dio.get('user/$userId}',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      _updateLoading(false);
      UserDetailResponseEntity entity = UserDetailResponseEntity();
      userDetailResponseEntityFromJson(entity, response.data);
      setState(() {
        data = entity.data;
      });
    } on DioError catch (e) {
      _updateLoading(false);
    }
  }

  void _updateLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  void requestUpdateFavoriteApi() async {
    try {
      var response = await dio.post('addFavorite',
          data: {"vendor_id": data.id},
          options: Options(headers: {"Authorization": "Bearer $token"}));

      if(response.statusCode==200){
        setState(() {
          data.favorite= response.data['data'];
        });
      }
    } on DioError catch (e) {

    }
  }
}
