import 'package:badhat_b2b/data/order_placed_response_entity.dart';
import 'package:badhat_b2b/data/user_detail_response_entity.dart';

orderPlacedResponseEntityFromJson(OrderPlacedResponseEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new List<OrderPlacedResponseData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new OrderPlacedResponseData().fromJson(v));
		});
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	return data;
}

Map<String, dynamic> orderPlacedResponseEntityToJson(OrderPlacedResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['message'] = entity.message;
	return data;
}

orderPlacedResponseDataFromJson(OrderPlacedResponseData data, Map<String, dynamic> json) {
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
		data.items = new List<OrderPlacedResponseDataItem>();
		(json['items'] as List).forEach((v) {
			data.items.add(new OrderPlacedResponseDataItem().fromJson(v));
		});
	}
	if (json['vendor'] != null) {
		data.vendor = json['vendor'];
	}

	return data;
}

Map<String, dynamic> orderPlacedResponseDataToJson(OrderPlacedResponseData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['user_id'] = entity.userId;
	data['status'] = entity.status;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	if (entity.items != null) {
		data['items'] =  entity.items.map((v) => v.toJson()).toList();
	}
	data['vendor'] = entity.vendor;
	return data;
}

orderPlacedResponseDataItemFromJson(OrderPlacedResponseDataItem data, Map<String, dynamic> json) {
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
	return data;
}

Map<String, dynamic> orderPlacedResponseDataItemToJson(OrderPlacedResponseDataItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['order_id'] = entity.orderId;
	data['product_id'] = entity.productId;
	data['price'] = entity.price;
	data['quantity'] = entity.quantity;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	return data;
}