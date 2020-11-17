import 'dart:convert';

import 'package:badhat_b2b/data/subcategory_entity.dart';
import 'package:badhat_b2b/data/vertical_entity.dart';
import 'package:badhat_b2b/generated/json/subcategory_entity_helper.dart';
import 'package:badhat_b2b/generated/json/vertical_entity_helper.dart';
import 'package:badhat_b2b/ui/dashboard/search/search_view.dart';
import 'package:badhat_b2b/utils/contants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/category_entity.dart';
import '../../../data/search_result_entity.dart';
import '../../../data/state_district_model_entity.dart';
import '../../../generated/json/category_entity_helper.dart';
import '../../../generated/json/search_result_entity_helper.dart';
import '../../../generated/json/state_district_model_entity_helper.dart';
import '../../../main.dart';
import '../../../utils/extensions.dart';

class SearchController extends StatefulWidget {
  @override
  SearchControllerState createState() => SearchControllerState();
}

class SearchControllerState extends State<SearchController> {
  @override
  Widget build(BuildContext context) => SearchView(this);

  // variables
  TextEditingController searchController = TextEditingController();
  List<SearchResultData> searchResults = List<SearchResultData>();
  bool loading = false;
  List<StateDistrictModelState> states = List();
  List<String> districts = List();
  List<CategoryData> categories = List();
  List<SubcategoryData> subcategories = List();
  List<VerticalData> verticals = List();
  String selectedState,
      selectedDistrict,
      selectedBusinessType;
  int selectedCategoryId = -1;
  bool showFilter = true;
  int selectedCategory;
  int selectedSubcategory;
  int selectedVertical;
  @override
  void initState() {
    _fetchCategories();

    StateDistrictModelEntity entity = StateDistrictModelEntity();
    stateDistrictModelEntityFromJson(entity, jsonDecode(stateDistrict));
    states.addAll(entity.states);
    super.initState();
  }

  void showFilterSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return _bottomSheet();
        });
  }

  void _fetchCategories() {
    dio
        .get(
          'categories',
        )
        .catchError((e) {})
        .then((response) {
      if (response.statusCode == 200) {
        CategoryEntity entity = CategoryEntity();
        categoryEntityFromJson(entity, response.data);
        categories = entity.data;
      } else {}
    }).catchError((e) {});
  }

  void _fetchsubCategory(int selectedCategory) async{
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    dio
        .get(
      'getsubCategories/${selectedCategory}',
        options: Options(headers: {"Authorization": "Bearer $token"})

    )
        .catchError((e) {})
        .then((response) {
      if (response.statusCode == 200) {
        SubcategoryEntity entity = SubcategoryEntity();
        subcategoryEntityFromJson(entity, response.data);
        subcategories = entity.data;
      } else {}
    }).catchError((e) {});
  }

  void _fetchVertical(int selectedVertical) async{
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    dio
        .get(
        'getVerticals/${selectedVertical}',
        options: Options(headers: {"Authorization": "Bearer $token"})

    )
        .catchError((e) {})
        .then((response) {
      if (response.statusCode == 200) {
        VerticalEntity entity = VerticalEntity();
        verticalEntityFromJson(entity, response.data);
        verticals = entity.data;
      } else {}
    }).catchError((e) {});
  }

  void doSearch() async {
    if (searchController.text.isEmpty) {
      return;
    }
    _updateLoading(true);
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var response = await dio.post('search',
          data: {
            "search_key": searchController.text,
            "business_category": selectedCategory,
            "business_type": selectedBusinessType,
            "state": selectedState,
            "district": selectedDistrict
          },
          options: Options(headers: {"Authorization": "Bearer $token"}));
      _updateLoading(false);
      SearchResultEntity entity = SearchResultEntity();
      searchResultEntityFromJson(entity, response.data);
      setState(() {
        searchResults = entity.data;
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

  Widget _bottomSheet() {
    return showFilter
        ? AnimatedContainer(
            duration: Duration(seconds: 2),
            child: Card(
              elevation: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Apply Filter")
                      .fontSize(20)
                      .fontWeight(FontWeight.bold)
                      .paddingAll(8),
                  Divider(
                    thickness: 2,
                  ),
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
                                  selectedState = stateName;
                                  setState(() {
                                    loadDistrict(stateName);
                                  });

                                },
                                value: selectedState,
                                items: states
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
                              border: OutlineInputBorder(),
                              hintText: "District"),
                          onChanged: (district) {
                            selectedDistrict = district;
                          },
                          value: selectedDistrict,
                          items: districts
                              .map((e) => DropdownMenuItem(
                                    child: Text(
                                      e,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    value: e,
                                  ))
                              .toList(),
                        ).paddingAll(4),
                      ),
                    ],
                  ),
                  DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Business Type"),
                          onChanged: (x) {
                            selectedBusinessType = x;
                          },
                      value: selectedBusinessType,
                          items: userType
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList())
                      .paddingAll(4),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Category"),
                      onChanged: (x) {
                        selectedCategory = x;
                        setState(() {
                          _fetchsubCategory(selectedCategory);
                        });

                      },
                      value: selectedCategory,
                      items: categories
                          .map((e) => DropdownMenuItem(
                          value: e.id, child: Text(e.name)))
                          .toList())
                      .paddingAll(4),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "SubCategories"),
                      onChanged: (x) {
                        selectedSubcategory = x;
                        setState(() {
                          _fetchVertical(selectedSubcategory);
                        });
                      },
                      value: selectedSubcategory,
                      items: subcategories
                          .map((e) => DropdownMenuItem(
                          value: e.id, child: Text(e.name)))
                          .toList())
                      .paddingAll(4),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Verticals"),
                      onChanged: (x) {
                        selectedVertical = x;
                      },
                      value: selectedVertical,
                      items: verticals
                          .map((e) => DropdownMenuItem(
                          value: e.id, child: Text(e.name)))
                          .toList())
                      .paddingAll(4),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Colors.blue.withOpacity(0.5),
                          child: Text("Reset"),
                          onPressed: () {
                            selectedState = null;
                            selectedDistrict = null;
                            selectedBusinessType = null;
                            selectedCategory = null;
                            doSearch();
                            Navigator.pop(context);
                          },
                        ).container(height: 40).paddingAll(4),
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Colors.green.withOpacity(0.5),
                          child: Text("Apply"),
                          onPressed: () {
                            doSearch();
                            Navigator.pop(context);
                          },
                        ).container(height: 40).paddingAll(4),
                      ),
                    ],
                  ).paddingAll(16)
                ],
              ),
            ),
          )
        : Container();
  }

  void loadDistrict(stateName) {
    setState(() {
      int stateIndex =
          states.indexWhere((element) => element.state == stateName);
      districts.clear();
      districts.addAll(states[stateIndex].districts);
      selectedDistrict = districts[0];
      print(jsonEncode(districts));
    });
  }

  int getBusinessTypeEnum(String type){
//    print(type);
    return userType.indexOf(type);
  }
}
