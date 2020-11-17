import 'package:badhat_b2b/data/notification_response_entity.dart';

notificationResponseEntityFromJson(NotificationResponseEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new List<NotificationResponseData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new NotificationResponseData().fromJson(v));
		});
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	return data;
}

Map<String, dynamic> notificationResponseEntityToJson(NotificationResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['message'] = entity.message;
	return data;
}

notificationResponseDataFromJson(NotificationResponseData data, Map<String, dynamic> json) {
	if (json['message'] != null) {
		data.message = json['message']?.toString();
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
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	return data;
}

Map<String, dynamic> notificationResponseDataToJson(NotificationResponseData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['message'] = entity.message;
	data['user_id'] = entity.userId;
	data['vendor_id'] = entity.vendorId;
	data['updated_at'] = entity.updatedAt;
	data['created_at'] = entity.createdAt;
	data['id'] = entity.id;
	return data;
}