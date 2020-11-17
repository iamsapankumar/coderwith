import 'package:badhat_b2b/generated/json/base/json_convert_content.dart';
import 'package:badhat_b2b/generated/json/base/json_filed.dart';

class ProductDetailEntity with JsonConvert<ProductDetailEntity> {
	ProductDetailData data;
	String message;
}

class ProductDetailData with JsonConvert<ProductDetailData> {
	int id;
	String name;
	@JSONField(name: "category_id")
	int categoryId;
	@JSONField(name: "sub_category_id")
	int subCategoryId;
	@JSONField(name: "vertical_id")
	int verticalId;
	String image;
	@JSONField(name: "user_id")
	int userId;
	String description;
	int moq;
	String price;
	@JSONField(name: "created_at")
	String createdAt;
	@JSONField(name: "updated_at")
	String updatedAt;
	@JSONField(name: "can_delete")
	bool canDelete;
	ProductDetailDataSubcategory subcategory;
	ProductDetailDataVertical vertical;
}

class ProductDetailDataSubcategory with JsonConvert<ProductDetailDataSubcategory> {
	int id;
	String name;
	@JSONField(name: "category_id")
	int categoryId;
	@JSONField(name: "updated_at")
	String updatedAt;
	@JSONField(name: "created_at")
	String createdAt;
}

class ProductDetailDataVertical with JsonConvert<ProductDetailDataVertical> {
	int id;
	String name;
	@JSONField(name: "subcategory_id")
	int subcategoryId;
	@JSONField(name: "updated_at")
	String updatedAt;
	@JSONField(name: "created_at")
	String createdAt;
}
