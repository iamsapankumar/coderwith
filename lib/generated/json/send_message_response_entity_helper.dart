import 'package:badhat_b2b/data/send_message_response_entity.dart';
import '../../data/chat_response_entity.dart';

sendMessageResponseEntityFromJson(SendMessageResponseEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new ChatResponseData().fromJson(json['data']);
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	return data;
}

Map<String, dynamic> sendMessageResponseEntityToJson(SendMessageResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['message'] = entity.message;
	return data;
}

sendMessageResponseDataFromJson(ChatResponseData data, Map<String, dynamic> json) {
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

Map<String, dynamic> sendMessageResponseDataToJson(ChatResponseData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['room_id'] = entity.roomId;
	data['sender_id'] = entity.senderId;
	data['message'] = entity.message;
	data['updated_at'] = entity.updatedAt;
	data['created_at'] = entity.createdAt;
	return data;
}