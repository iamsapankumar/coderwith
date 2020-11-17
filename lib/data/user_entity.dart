import 'package:badhat_b2b/generated/json/base/json_convert_content.dart';
import 'package:badhat_b2b/generated/json/base/json_filed.dart';

class UserEntity with JsonConvert<UserEntity> {
	UserData data;
	String message;
}

class UserData with JsonConvert<UserData> {

	@JSONField(name: "access_token")
	String accessToken;
	@JSONField(name: "token_type")
	String tokenType;
	String image;
	UserDataUser user;
	@JSONField(name: "expires_in")
	int expiresIn;
	@JSONField(name: "otp")
	int otp;
}

class UserDataUser with JsonConvert<UserDataUser> {
	int id;
	String name;
	@JSONField(name: "business_name")
	String businessName;
}
