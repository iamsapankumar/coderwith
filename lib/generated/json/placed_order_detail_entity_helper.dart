import 'package:badhat_b2b/data/placed_order_detail_entity.dart';
import '../../data/user_detail_response_entity.dart';

placedOrderDetailEntityFromJson(PlacedOrderDetailEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new PlacedOrderDetailData().fromJson(json['data']);
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	return data;
}

Map<String, dynamic> placedOrderDetailEntityToJson(PlacedOrderDetailEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['message'] = entity.message;
	return data;
}

placedOrderDetailDataFromJson(PlacedOrderDetailData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['user_id'] != null) {
		data.userId = json['user_id']?.toInt();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toString();
	}
	if (json['created_at'] != null) {
		data.createdAt = json['created_at']?.toString();
	}
	if (json['updated_at'] != null) {
		data.updatedAt = json['updated_at']?.toString();
	}
	if (json['items'] != null) {
		data.items = new List<PlacedOrderDetailDataItem>();
		(json['items'] as List).forEach((v) {
			data.items.add(new PlacedOrderDetailDataItem().fromJson(v));
		});
	}
	if (json['user'] != null) {
		data.user = new UserDetailResponseData().fromJson(json['user']);
	}
	return data;
}

Map<String, dynamic> placedOrderDetailDataToJson(PlacedOrderDetailData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['user_id'] = entity.userId;
	data['status'] = entity.status;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	if (entity.items != null) {
		data['items'] =  entity.items.map((v) => v.toJson()).toList();
	}
	return data;
}

placedOrderDetailDataItemFromJson(PlacedOrderDetailDataItem data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['order_id'] != null) {
		data.orderId = json['order_id']?.toInt();
	}
	if (json['product_id'] != null) {
		data.productId = json['product_id']?.toInt();
	}
	if (json['price'] != null) {
		data.price = json['price']?.toString();
	}
	if (json['quantity'] != null) {
		data.quantity = json['quantity']?.toInt();
	}
	if (json['created_at'] != null) {
		data.createdAt = json['created_at']?.toString();
	}
	if (json['updated_at'] != null) {
		data.updatedAt = json['updated_at']?.toString();
	}
	if (json['product'] != null) {
		data.product = new PlacedOrderDetailDataItemsProduct().fromJson(json['product']);
	}
	return data;
}

Map<String, dynamic> placedOrderDetailDataItemToJson(PlacedOrderDetailDataItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['order_id'] = entity.orderId;
	data['product_id'] = entity.productId;
	data['price'] = entity.price;
	data['quantity'] = entity.quantity;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	if (entity.product != null) {
		data['product'] = entity.product.toJson();
	}
	return data;
}

placedOrderDetailDataItemsProductFromJson(PlacedOrderDetailDataItemsProduct data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['image'] != null) {
		data.image = json['image']?.toString();
	}
	if (json['user_id'] != null) {
		data.userId = json['user_id']?.toInt();
	}
	if (json['vendor'] != null) {
		data.vendor = new PlacedOrderDetailDataItemsProductVendor().fromJson(json['vendor']);
	}
	return data;
}

Map<String, dynamic> placedOrderDetailDataItemsProductToJson(PlacedOrderDetailDataItemsProduct entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['image'] = entity.image;
	data['user_id'] = entity.userId;
	if (entity.vendor != null) {
		data['vendor'] = entity.vendor.toJson();
	}
	return data;
}

placedOrderDetailDataItemsProductVendorFromJson(PlacedOrderDetailDataItemsProductVendor data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['business_name'] != null) {
		data.businessName = json['business_name']?.toString();
	}
	return data;
}

Map<String, dynamic> placedOrderDetailDataItemsProductVendorToJson(PlacedOrderDetailDataItemsProductVendor entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['business_name'] = entity.businessName;
	return data;
}