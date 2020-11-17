import 'package:badhat_b2b/generated/json/base/json_convert_content.dart';
import 'package:badhat_b2b/generated/json/base/json_filed.dart';

class SubcategoryResponseEntity with JsonConvert<SubcategoryResponseEntity> {
	List<SubcategoryResponseData> data;
	String message;
}

class SubcategoryResponseData with JsonConvert<SubcategoryResponseData> {
	int id;
	String name;
	@JSONField(name: "category_id")
	int categoryId;
	@JSONField(name: "updated_at")
	String updatedAt;
	@JSONField(name: "created_at")
	String createdAt;
	List<SubcategoryVertical> verticals;
}

class SubcategoryVertical with JsonConvert<SubcategoryVertical> {
	int id;
	String name;
	@JSONField(name: "subcategory_id")
	int subcategoryId;
	@JSONField(name: "updated_at")
	String updatedAt;
	@JSONField(name: "created_at")
	String createdAt;
}
