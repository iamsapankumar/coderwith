import 'package:badhat_b2b/data/user_detail_response_entity.dart';

userDetailResponseEntityFromJson(UserDetailResponseEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new UserDetailResponseData().fromJson(json['data']);
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	return data;
}

Map<String, dynamic> userDetailResponseEntityToJson(UserDetailResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['message'] = entity.message;
	return data;
}

userDetailResponseDataFromJson(UserDetailResponseData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['room_id'] != null) {
		data.roomId = json['room_id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['email'] != null) {
		data.email = json['email'];
	}
	if (json['image'] != null) {
		data.image = json['image']?.toString();
	}
	if (json['business_name'] != null) {
		data.businessName = json['business_name']?.toString();
	}
	if (json['mobile'] != null) {
		data.mobile = json['mobile']?.toString();
	}
	if (json['gstin'] != null) {
		data.gstin = json['gstin']?.toString();
	}
	if (json['state'] != null) {
		data.state = json['state']?.toString();
	}
	if (json['district'] != null) {
		data.district = json['district']?.toString();
	}
	if (json['address'] != null) {
		data.address = json['address']?.toString();
	}
	if (json['city'] != null) {
		data.city = json['city']?.toString();
	}
	if (json['pincode'] != null) {
		data.pincode = json['pincode']?.toString();
	}
	if (json['category'] != null) {
		data.category = json['category']?.toString();
	}
	if (json['latitude'] != null) {
		data.latitude = json['latitude']?.toString();
	}
	if (json['longitude'] != null) {
		data.longitude = json['longitude']?.toString();
	}
	if (json['business_type'] != null) {
		data.businessType = json['business_type']?.toString();
	}
	if (json['business_category'] != null) {
		data.businessCategory = json['business_category']?.toString();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	if (json['created_at'] != null) {
		data.createdAt = json['created_at']?.toString();
	}
	if (json['updated_at'] != null) {
		data.updatedAt = json['updated_at']?.toString();
	}
	if (json['favorite'] != null) {
		data.favorite = json['favorite'];
	}
	if (json['products'] != null) {
		data.products = new List<UserDetailResponseDataProduct>();
		(json['products'] as List).forEach((v) {
			data.products.add(new UserDetailResponseDataProduct().fromJson(v));
		});
	}
	if (json['subcategories'] != null) {
		data.subCategory = new List<String>();
		(json['subcategories'] as List).forEach((v) {
			data.subCategory.add(v);
		});
	}
	if (json['verticals'] != null) {
		data.verticals = new List<String>();
		(json['verticals'] as List).forEach((v) {
			data.verticals.add(v);
		});
	}
	return data;
}

Map<String, dynamic> userDetailResponseDataToJson(UserDetailResponseData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['room_id'] = entity.roomId;
	data['name'] = entity.name;
	data['email'] = entity.email;
	data['image'] = entity.image;
	data['business_name'] = entity.businessName;
	data['mobile'] = entity.mobile;
	data['gstin'] = entity.gstin;
	data['state'] = entity.state;
	data['district'] = entity.district;
	data['address'] = entity.address;
	data['city'] = entity.city;
	data['pincode'] = entity.pincode;
	data['category'] = entity.category;
	data['latitude'] = entity.latitude;
	data['longitude'] = entity.longitude;
	data['business_type'] = entity.businessType;
	data['business_category'] = entity.businessCategory;
	data['status'] = entity.status;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	data['favorite'] = entity.favorite;
	if (entity.products != null) {
		data['products'] =  entity.products.map((v) => v.toJson()).toList();
	}
	return data;
}

userDetailResponseDataProductFromJson(UserDetailResponseDataProduct data, Map<String, dynamic> json) {
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

Map<String, dynamic> userDetailResponseDataProductToJson(UserDetailResponseDataProduct entity) {
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