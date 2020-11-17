import 'package:badhat_b2b/generated/json/base/json_convert_content.dart';
import 'package:badhat_b2b/generated/json/base/json_filed.dart';

class CategoryEntity with JsonConvert<CategoryEntity> {
	List<CategoryData> data;
	String message;
}

class CategoryData with JsonConvert<CategoryData> {
	int id;
	String name;
	@JSONField(name: "created_at")
	String createdAt;
	@JSONField(name: "updated_at")
	String updatedAt;
}
