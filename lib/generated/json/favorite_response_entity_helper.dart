import 'package:badhat_b2b/data/favorite_response_entity.dart';

favoriteResponseEntityFromJson(FavoriteResponseEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new List<FavoriteResponseData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new FavoriteResponseData().fromJson(v));
		});
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	return data;
}

Map<String, dynamic> favoriteResponseEntityToJson(FavoriteResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['message'] = entity.message;
	return data;
}

favoriteResponseDataFromJson(FavoriteResponseData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['user_id'] != null) {
		data.userId = json['user_id']?.toInt();
	}
	if (json['vendor_id'] != null) {
		data.vendorId = json['vendor_id']?.toInt();
	}
	if (json['created_at'] != null) {
		data.createdAt = json['created_at']?.toString();
	}
	if (json['updated_at'] != null) {
		data.updatedAt = json['updated_at']?.toString();
	}
	if (json['vendor'] != null) {
		data.vendor = new FavoriteResponseDataVendor().fromJson(json['vendor']);
	}
	return data;
}

Map<String, dynamic> favoriteResponseDataToJson(FavoriteResponseData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['user_id'] = entity.userId;
	data['vendor_id'] = entity.vendorId;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	if (entity.vendor != null) {
		data['vendor'] = entity.vendor.toJson();
	}
	return data;
}

favoriteResponseDataVendorFromJson(FavoriteResponseDataVendor data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
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
	if (json['state'] != null) {
		data.state = json['state']?.toString();
	}
	if (json['district'] != null) {
		data.district = json['district']?.toString();
	}
	if (json['pincode'] != null) {
		data.pincode = json['pincode'];
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
	if (json['room_id'] != null) {
		data.roomId = json['room_id']?.toInt();
	}
	return data;
}

Map<String, dynamic> favoriteResponseDataVendorToJson(FavoriteResponseDataVendor entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['email'] = entity.email;
	data['image'] = entity.image;
	data['business_name'] = entity.businessName;
	data['mobile'] = entity.mobile;
	data['state'] = entity.state;
	data['district'] = entity.district;
	data['pincode'] = entity.pincode;
	data['latitude'] = entity.latitude;
	data['longitude'] = entity.longitude;
	data['business_type'] = entity.businessType;
	data['business_category'] = entity.businessCategory;
	data['status'] = entity.status;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	data['room_id'] = entity.roomId;
	return data;
}