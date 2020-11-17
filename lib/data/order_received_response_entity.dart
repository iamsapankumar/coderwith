import 'package:badhat_b2b/data/user_detail_response_entity.dart';
import 'package:badhat_b2b/generated/json/base/json_convert_content.dart';
import 'package:badhat_b2b/generated/json/base/json_filed.dart';

class OrderReceivedResponseEntity with JsonConvert<OrderReceivedResponseEntity> {
	List<OrderReceivedResponseData> data;
	String message;
}

class OrderReceivedResponseData with JsonConvert<OrderReceivedResponseData> {
	int id;
	@JSONField(name: "user_id")
	int userId;
	String status;
	@JSONField(name: "created_at")
	String createdAt;
	@JSONField(name: "updated_at")
	String updatedAt;
	List<OrderReceivedResponseDataItem> items;
	UserDetailResponseData user;
	dynamic vendor;

	double getTotal(){
		double total =0.0;
		items.forEach((element) {
			total+= element.quantity*double.parse(element.price);
		});
		return total;
	}
}

class OrderReceivedResponseDataItem with JsonConvert<OrderReceivedResponseDataItem> {
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
