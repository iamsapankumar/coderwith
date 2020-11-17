import 'package:badhat_b2b/generated/json/base/json_convert_content.dart';
import 'package:badhat_b2b/generated/json/base/json_filed.dart';

class CartResponseEntity with JsonConvert<CartResponseEntity> {
	List<CartResponseData> data;
	String message;
}

class CartResponseData with JsonConvert<CartResponseData> {
	int id;
	@JSONField(name: "user_id")
	int userId;
	@JSONField(name: "product_id")
	int productId;
	int quantity;
	@JSONField(name: "updated_at")
	String updatedAt;
	@JSONField(name: "created_at")
	String createdAt;
	CartResponseDataProduct product;
}

class CartResponseDataProduct with JsonConvert<CartResponseDataProduct> {
	int id;
	String name;
	@JSONField(name: "category_id")
	int categoryId;
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
}
