import 'package:badhat_b2b/generated/json/base/json_convert_content.dart';
import 'package:badhat_b2b/generated/json/base/json_filed.dart';
import '../data/user_detail_response_entity.dart';

class PlacedOrderDetailEntity with JsonConvert<PlacedOrderDetailEntity> {
	PlacedOrderDetailData data;
	String message;
}

class PlacedOrderDetailData with JsonConvert<PlacedOrderDetailData> {
	int id;
	@JSONField(name: "user_id")
	int userId;
	String status;
	@JSONField(name: "created_at")
	String createdAt;
	@JSONField(name: "updated_at")
	String updatedAt;
	List<PlacedOrderDetailDataItem> items;
	UserDetailResponseData user;

	double getTotal(){
		double total =0.0;
		items.forEach((element) {
			total+= element.quantity*double.parse(element.price);
		});
		return total;
	}
}

class PlacedOrderDetailDataItem with JsonConvert<PlacedOrderDetailDataItem> {
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
	PlacedOrderDetailDataItemsProduct product;
}

class PlacedOrderDetailDataItemsProduct with JsonConvert<PlacedOrderDetailDataItemsProduct> {
	int id;
	String name;
	String image;
	@JSONField(name: "user_id")
	int userId;
	PlacedOrderDetailDataItemsProductVendor vendor;
}

class PlacedOrderDetailDataItemsProductVendor with JsonConvert<PlacedOrderDetailDataItemsProductVendor> {
	int id;
	String name;
	@JSONField(name: "business_name")
	String businessName;
}
