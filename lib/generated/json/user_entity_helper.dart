import 'package:badhat_b2b/data/user_entity.dart';

userEntityFromJson(UserEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new UserData().fromJson(json['data']);
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	return data;
}

Map<String, dynamic> userEntityToJson(UserEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['message'] = entity.message;
	return data;
}

userDataFromJson(UserData data, Map<String, dynamic> json) {
	if (json['access_token'] != null) {
		data.accessToken = json['access_token']?.toString();
	}
	if (json['token_type'] != null) {
		data.tokenType = json['token_type']?.toString();
	}
	if (json['image'] != null) {
		data.image = json['image']?.toString();
	}
	if (json['user'] != null) {
		data.user = new UserDataUser().fromJson(json['user']);
	}
	if (json['expires_in'] != null) {
		data.expiresIn = json['expires_in']?.toInt();
	}
	return data;
}

Map<String, dynamic> userDataToJson(UserData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['access_token'] = entity.accessToken;
	data['token_type'] = entity.tokenType;
	data['image'] = entity.image;
	if (entity.user != null) {
		data['user'] = entity.user.toJson();
	}
	data['expires_in'] = entity.expiresIn;
	return data;
}

userDataUserFromJson(UserDataUser data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['business_name'] != null) {
		data.businessName = json['business_name']?.toString();
	}
	return data;
}

Map<String, dynamic> userDataUserToJson(UserDataUser entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['business_name'] = entity.businessName;
	return data;
}