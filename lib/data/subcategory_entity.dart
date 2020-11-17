import 'package:badhat_b2b/generated/json/base/json_convert_content.dart';
import 'package:badhat_b2b/generated/json/base/json_filed.dart';

class SubcategoryEntity with JsonConvert<SubcategoryEntity> {
  List<SubcategoryData> data;
  String message;
}

class SubcategoryData with JsonConvert<SubcategoryData> {
  int id;
  String name;
  @JSONField(name: "category_id")
  int categoryId;
  @JSONField(name: "updated_at")
  String updatedAt;
  @JSONField(name: "created_at")
  String createdAt;
}