import 'package:badhat_b2b/generated/json/base/json_convert_content.dart';
import 'package:badhat_b2b/generated/json/base/json_filed.dart';

class VerticalEntity with JsonConvert<VerticalEntity> {
  List<VerticalData> data;
  String message;
}

class VerticalData with JsonConvert<VerticalData> {
  int id;
  String name;
  @JSONField(name: "created_at")
  String createdAt;
  @JSONField(name: "updated_at")
  String updatedAt;
}
