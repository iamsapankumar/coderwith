import 'package:badhat_b2b/data/product_detail_entity.dart';

productDetailEntityFromJson(ProductDetailEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new ProductDetailData().fromJson(json['data']);
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	return data;
}

Map<String, dynamic> productDetailEntityToJson(ProductDetailEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['message'] = entity.message;
	return data;
}

productDetailDataFromJson(ProductDetailData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['category_id'] != null) {
		data.categoryId = json['category_id']?.toInt();
	}
	if (json['sub_category_id'] != null) {
		data.subCategoryId = json['sub_category_id']?.toInt();
	}
	if (json['vertical_id'] != null) {
		data.verticalId = json['vertical_id']?.toInt();
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
	if (json['can_delete'] != null) {
		data.canDelete = json['can_delete'];
	}
	if (json['subcategory'] != null) {
		data.subcategory = new ProductDetailDataSubcategory().fromJson(json['subcategory']);
	}
	if (json['vertical'] != null) {
		data.vertical = new ProductDetailDataVertical().fromJson(json['vertical']);
	}
	return data;
}

Map<String, dynamic> productDetailDataToJson(ProductDetailData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['category_id'] = entity.categoryId;
	data['sub_category_id'] = entity.subCategoryId;
	data['vertical_id'] = entity.verticalId;
	data['image'] = entity.image;
	data['user_id'] = entity.userId;
	data['description'] = entity.description;
	data['moq'] = entity.moq;
	data['price'] = entity.price;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	data['can_delete'] = entity.canDelete;
	if (entity.subcategory != null) {
		data['subcategory'] = entity.subcategory.toJson();
	}
	if (entity.vertical != null) {
		data['vertical'] = entity.vertical.toJson();
	}
	return data;
}

productDetailDataSubcategoryFromJson(ProductDetailDataSubcategory data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['category_id'] != null) {
		data.categoryId = json['category_id']?.toInt();
	}
	if (json['updated_at'] != null) {
		data.updatedAt = json['updated_at']?.toString();
	}
	if (json['created_at'] != null) {
		data.createdAt = json['created_at']?.toString();
	}
	return data;
}

Map<String, dynamic> productDetailDataSubcategoryToJson(ProductDetailDataSubcategory entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['category_id'] = entity.categoryId;
	data['updated_at'] = entity.updatedAt;
	data['created_at'] = entity.createdAt;
	return data;
}

productDetailDataVerticalFromJson(ProductDetailDataVertical data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['subcategory_id'] != null) {
		data.subcategoryId = json['subcategory_id']?.toInt();
	}
	if (json['updated_at'] != null) {
		data.updatedAt = json['updated_at']?.toString();
	}
	if (json['created_at'] != null) {
		data.createdAt = json['created_at']?.toString();
	}
	return data;
}

Map<String, dynamic> productDetailDataVerticalToJson(ProductDetailDataVertical entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['subcategory_id'] = entity.subcategoryId;
	data['updated_at'] = entity.updatedAt;
	data['created_at'] = entity.createdAt;
	return data;
}