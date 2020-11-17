import 'package:badhat_b2b/data/subcategoryresponse_entity.dart';

subcategoryResponseEntityFromJson(SubcategoryResponseEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new List<SubcategoryResponseData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new SubcategoryResponseData().fromJson(v));
		});
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	return data;
}

Map<String, dynamic> subcategoryResponseEntityToJson(SubcategoryResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['message'] = entity.message;
	return data;
}

subcategoryResponseDataFromJson(SubcategoryResponseData data, Map<String, dynamic> json) {
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
	if (json['verticals'] != null) {
		data.verticals = new List<SubcategoryVertical>();
		(json['verticals'] as List).forEach((v) {
			data.verticals.add(new SubcategoryVertical().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> subcategoryResponseDataToJson(SubcategoryResponseData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['category_id'] = entity.categoryId;
	data['updated_at'] = entity.updatedAt;
	data['created_at'] = entity.createdAt;
	if (entity.verticals != null) {
		data['verticals'] =  entity.verticals.map((v) => v.toJson()).toList();
	}
	return data;
}

subcategoryVerticalFromJson(SubcategoryVertical data, Map<String, dynamic> json) {
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

Map<String, dynamic> subcategoryVerticalToJson(SubcategoryVertical entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['subcategory_id'] = entity.subcategoryId;
	data['updated_at'] = entity.updatedAt;
	data['created_at'] = entity.createdAt;
	return data;
}
