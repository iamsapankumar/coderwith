import 'package:badhat_b2b/data/chat_response_entity.dart';

chatResponseEntityFromJson(ChatResponseEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new List<ChatResponseData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new ChatResponseData().fromJson(v));
		});
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	return data;
}

Map<String, dynamic> chatResponseEntityToJson(ChatResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['message'] = entity.message;
	return data;
}

chatResponseDataFromJson(ChatResponseData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['room_id'] != null) {
		data.roomId = json['room_id']?.toInt();
	}
	if (json['sender_id'] != null) {
		data.senderId = json['sender_id']?.toInt();
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	if (json['updated_at'] != null) {
		data.updatedAt = json['updated_at']?.toString();
	}
	if (json['created_at'] != null) {
		data.createdAt = json['created_at']?.toString();
	}
	return data;
}

Map<String, dynamic> chatResponseDataToJson(ChatResponseData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['room_id'] = entity.roomId;
	data['sender_id'] = entity.senderId;
	data['message'] = entity.message;
	data['updated_at'] = entity.updatedAt;
	data['created_at'] = entity.createdAt;
	return data;
}