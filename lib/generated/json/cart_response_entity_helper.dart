import 'package:badhat_b2b/data/cart_response_entity.dart';

cartResponseEntityFromJson(CartResponseEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new List<CartResponseData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new CartResponseData().fromJson(v));
		});
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	return data;
}

Map<String, dynamic> cartResponseEntityToJson(CartResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['message'] = entity.message;
	return data;
}

cartResponseDataFromJson(CartResponseData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['user_id'] != null) {
		data.userId = json['user_id']?.toInt();
	}
	if (json['product_id'] != null) {
		data.productId = json['product_id']?.toInt();
	}
	if (json['quantity'] != null) {
		data.quantity = json['quantity']?.toInt();
	}
	if (json['updated_at'] != null) {
		data.updatedAt = json['updated_at']?.toString();
	}
	if (json['created_at'] != null) {
		data.createdAt = json['created_at']?.toString();
	}
	if (json['product'] != null) {
		data.product = new CartResponseDataProduct().fromJson(json['product']);
	}
	return data;
}

Map<String, dynamic> cartResponseDataToJson(CartResponseData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['user_id'] = entity.userId;
	data['product_id'] = entity.productId;
	data['quantity'] = entity.quantity;
	data['updated_at'] = entity.updatedAt;
	data['created_at'] = entity.createdAt;
	if (entity.product != null) {
		data['product'] = entity.product.toJson();
	}
	return data;
}

cartResponseDataProductFromJson(CartResponseDataProduct data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['category_id'] != null) {
		data.categoryId = json['category_id']?.toInt();
	}
	if (json['image'] != null) {
		data.image = json['image']?.toString();
	}
	if (json['user_id'] != null) {
		data.userId = json['user_id']?.toInt();
	}
	if (json['description'] != null) {
		data.description = json['description']?.toString();
	}
	if (json['moq'] != null) {
		data.moq = json['moq']?.toInt();
	}
	if (json['price'] != null) {
		data.price = json['price']?.toString();
	}
	if (json['created_at'] != null) {
		data.createdAt = json['created_at']?.toString();
	}
	if (json['updated_at'] != null) {
		data.updatedAt = json['updated_at']?.toString();
	}
	return data;
}

Map<String, dynamic> cartResponseDataProductToJson(CartResponseDataProduct entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['category_id'] = entity.categoryId;
	data['image'] = entity.image;
	data['user_id'] = entity.userId;
	data['description'] = entity.description;
	data['moq'] = entity.moq;
	data['price'] = entity.price;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	return data;
}