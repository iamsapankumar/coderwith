import 'package:badhat_b2b/generated/json/base/json_convert_content.dart';
import 'package:badhat_b2b/generated/json/base/json_filed.dart';

class ProductEntity with JsonConvert<ProductEntity> {
	List<ProductData> data;
	String message;
}

class ProductData with JsonConvert<ProductData> {
	int id;
	String name;
	String image;
	String description;
	int moq;
	String price;
	@JSONField(name: "category_id")
	int categoryId;
	@JSONField(name: "can_delete")
	bool canDelete;
	ProductDataCategory category;
}

class ProductDataCategory with JsonConvert<ProductDataCategory> {
	int id;
	String name;
	@JSONField(name: "created_at")
	String createdAt;
	@JSONField(name: "updated_at")
	String updatedAt;
}
