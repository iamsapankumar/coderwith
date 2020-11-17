import 'package:badhat_b2b/data/order_received_response_entity.dart';
import 'package:badhat_b2b/data/user_detail_response_entity.dart';

orderReceivedResponseEntityFromJson(OrderReceivedResponseEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new List<OrderReceivedResponseData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new OrderReceivedResponseData().fromJson(v));
		});
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	return data;
}

Map<String, dynamic> orderReceivedResponseEntityToJson(OrderReceivedResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['message'] = entity.message;
	return data;
}

orderReceivedResponseDataFromJson(OrderReceivedResponseData data, Map<String, dynamic> json) {
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
		data.items = new List<OrderReceivedResponseDataItem>();
		(json['items'] as List).forEach((v) {
			data.items.add(new OrderReceivedResponseDataItem().fromJson(v));
		});
	}
	if (json['user'] != null) {
		data.user = UserDetailResponseData().fromJson(json['user']);
	}
	if (json['vendor'] != null) {
		data.vendor = json['vendor'];
	}
	return data;
}

Map<String, dynamic> orderReceivedResponseDataToJson(OrderReceivedResponseData entity) {
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

orderReceivedResponseDataItemFromJson(OrderReceivedResponseDataItem data, Map<String, dynamic> json) {
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

Map<String, dynamic> orderReceivedResponseDataItemToJson(OrderReceivedResponseDataItem entity) {
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