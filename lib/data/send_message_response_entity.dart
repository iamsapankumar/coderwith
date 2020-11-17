import 'package:badhat_b2b/generated/json/base/json_convert_content.dart';
import 'package:badhat_b2b/generated/json/base/json_filed.dart';
import '../data/chat_response_entity.dart';

class SendMessageResponseEntity with JsonConvert<SendMessageResponseEntity> {
	ChatResponseData data;
	String message;
}

//class SendMessageResponseData with JsonConvert<SendMessageResponseData> {
//	int id;
//	@JSONField(name: "room_id")
//	int roomId;
//	@JSONField(name: "sender_id")
//	int senderId;
//	String message;
//	@JSONField(name: "updated_at")
//	String updatedAt;
//	@JSONField(name: "created_at")
//	String createdAt;
//}
