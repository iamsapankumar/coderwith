import 'package:badhat_b2b/generated/json/base/json_convert_content.dart';
import 'package:badhat_b2b/generated/json/base/json_filed.dart';

class NotificationResponseEntity with JsonConvert<NotificationResponseEntity> {
	List<NotificationResponseData> data;
	String message;
}

class NotificationResponseData with JsonConvert<NotificationResponseData> {
	String message;
	@JSONField(name: "user_id")
	int userId;
	@JSONField(name: "vendor_id")
	int vendorId;
	@JSONField(name: "updated_at")
	String updatedAt;
	@JSONField(name: "created_at")
	String createdAt;
	int id;
}
