import 'package:badhat_b2b/ui/dashboard/home/home_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/favorite_response_entity.dart';
import '../../../generated/json/favorite_response_entity_helper.dart';
import '../../../main.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

TextEditingController searchController = TextEditingController();
List<FavoriteResponseData> favorites = List<FavoriteResponseData>();
bool loading = true;
class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => HomeView(this);

  // variables
  @override
  void initState() {
    /*_updateLoading(true);*/
    requestFavoritesApi();
    /* _updateLoading(false);*/
    super.initState();
  }

  void requestFavoritesApi() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    /*_updateLoading(true);*/
    try {
      var response = await dio.get('favorites',
          options: Options(headers: {"Authorization": "Bearer $token"}));

      FavoriteResponseEntity entity = FavoriteResponseEntity();
      favoriteResponseEntityFromJson(entity, response.data);
      _updateLoading(false);
      setState(() {
        favorites = entity.data;
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
}
