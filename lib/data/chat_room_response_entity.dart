import 'package:badhat_b2b/generated/json/base/json_convert_content.dart';
import 'package:badhat_b2b/generated/json/base/json_filed.dart';

class ChatRoomResponseEntity with JsonConvert<ChatRoomResponseEntity> {
	List<ChatRoomResponseData> data;
	String message;
}

class ChatRoomResponseData with JsonConvert<ChatRoomResponseData> {
	int id;
	String name;
	@JSONField(name: "user_id")
	int userId;
	@JSONField(name: "vendor_id")
	int vendorId;
	@JSONField(name: "updated_at")
	String updatedAt;
	@JSONField(name: "created_at")
	String createdAt;
	ChatRoomResponseDataVendor vendor;
}

class ChatRoomResponseDataVendor with JsonConvert<ChatRoomResponseDataVendor> {
	int id;
	String name;
	@JSONField(name: "business_name")
	String businessName;
	String image;
	@JSONField(name: "room_id")
	int roomId;

	ChatRoomResponseDataVendor(
	{this.id, this.name, this.businessName, this.image, this.roomId});
}
