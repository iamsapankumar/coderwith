import 'package:badhat_b2b/data/chat_room_response_entity.dart';

chatRoomResponseEntityFromJson(ChatRoomResponseEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new List<ChatRoomResponseData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new ChatRoomResponseData().fromJson(v));
		});
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	return data;
}

Map<String, dynamic> chatRoomResponseEntityToJson(ChatRoomResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['message'] = entity.message;
	return data;
}

chatRoomResponseDataFromJson(ChatRoomResponseData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['user_id'] != null) {
		data.userId = json['user_id']?.toInt();
	}
	if (json['vendor_id'] != null) {
		data.vendorId = json['vendor_id']?.toInt();
	}
	if (json['updated_at'] != null) {
		data.updatedAt = json['updated_at']?.toString();
	}
	if (json['created_at'] != null) {
		data.createdAt = json['created_at']?.toString();
	}
	if (json['vendor'] != null) {
		data.vendor = new ChatRoomResponseDataVendor().fromJson(json['vendor']);
	}
	return data;
}

Map<String, dynamic> chatRoomResponseDataToJson(ChatRoomResponseData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['user_id'] = entity.userId;
	data['vendor_id'] = entity.vendorId;
	data['updated_at'] = entity.updatedAt;
	data['created_at'] = entity.createdAt;
	if (entity.vendor != null) {
		data['vendor'] = entity.vendor.toJson();
	}
	return data;
}

chatRoomResponseDataVendorFromJson(ChatRoomResponseDataVendor data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['business_name'] != null) {
		data.businessName = json['business_name']?.toString();
	}
	if (json['image'] != null) {
		data.image = json['image']?.toString();
	}
	if (json['room_id'] != null) {
		data.roomId = json['room_id']?.toInt();
	}
	return data;
}

Map<String, dynamic> chatRoomResponseDataVendorToJson(ChatRoomResponseDataVendor entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['business_name'] = entity.businessName;
	data['image'] = entity.image;
	data['room_id'] = entity.roomId;
	return data;
}