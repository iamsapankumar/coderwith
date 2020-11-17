import 'package:badhat_b2b/data/product_entity.dart';

productEntityFromJson(ProductEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new List<ProductData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new ProductData().fromJson(v));
		});
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	return data;
}

Map<String, dynamic> productEntityToJson(ProductEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['message'] = entity.message;
	return data;
}

productDataFromJson(ProductData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['image'] != null) {
		data.image = json['image']?.toString();
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
	if (json['category_id'] != null) {
		data.categoryId = json['category_id']?.toInt();
	}
	if (json['can_delete'] != null) {
		data.canDelete = json['can_delete'];
	}
	if (json['category'] != null) {
		data.category = new ProductDataCategory().fromJson(json['category']);
	}
	return data;
}

Map<String, dynamic> productDataToJson(ProductData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['image'] = entity.image;
	data['description'] = entity.description;
	data['moq'] = entity.moq;
	data['price'] = entity.price;
	data['category_id'] = entity.categoryId;
	data['can_delete'] = entity.canDelete;
	if (entity.category != null) {
		data['category'] = entity.category.toJson();
	}
	return data;
}

productDataCategoryFromJson(ProductDataCategory data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['created_at'] != null) {
		data.createdAt = json['created_at']?.toString();
	}
	if (json['updated_at'] != null) {
		data.updatedAt = json['updated_at']?.toString();
	}
	return data;
}

Map<String, dynamic> productDataCategoryToJson(ProductDataCategory entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	return data;
}