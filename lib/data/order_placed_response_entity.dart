import 'package:badhat_b2b/generated/json/base/json_convert_content.dart';
import 'package:badhat_b2b/generated/json/base/json_filed.dart';

import 'user_detail_response_entity.dart';

class OrderPlacedResponseEntity with JsonConvert<OrderPlacedResponseEntity> {
	List<OrderPlacedResponseData> data;
	String message;
}

class OrderPlacedResponseData with JsonConvert<OrderPlacedResponseData> {
	int id;
	@JSONField(name: "user_id")
	int userId;
	String status;
	@JSONField(name: "created_at")
	String createdAt;
	@JSONField(name: "updated_at")
	String updatedAt;
	List<OrderPlacedResponseDataItem> items;
	dynamic vendor;


	double getTotal(){
		double total =0.0;
		items.forEach((element) {
			total+= element.quantity*double.parse(element.price);
		});
		return total;
	}
}

class OrderPlacedResponseDataItem with JsonConvert<OrderPlacedResponseDataItem> {
	int id;
	@JSONField(name: "order_id")
	int orderId;
	@JSONField(name: "product_id")
	int productId;
	String price;
	int quantity;
	@JSONField(name: "created_at")
	String createdAt;
	@JSONField(name: "updated_at")
	String updatedAt;
}
