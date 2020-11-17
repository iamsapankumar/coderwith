import 'package:badhat_b2b/generated/json/base/json_convert_content.dart';
import 'package:badhat_b2b/generated/json/base/json_filed.dart';

class UserDetailResponseEntity with JsonConvert<UserDetailResponseEntity> {
	UserDetailResponseData data;
	String message;
}

class UserDetailResponseData with JsonConvert<UserDetailResponseData> {
	int id;
	@JSONField(name: "room_id")
	int roomId;
	String name;
	dynamic email;
	String image;
	@JSONField(name: "business_name")
	String businessName;
	String mobile;
	String gstin;
	String state;
	String district;
	String address;
	String city;
	String pincode;
	String category;
	String latitude;
	String longitude;
	@JSONField(name: "business_type")
	String businessType;
	@JSONField(name: "business_category")
	String businessCategory;
	int status;
	@JSONField(name: "created_at")
	String createdAt;
	@JSONField(name: "updated_at")
	String updatedAt;
	bool favorite;
	List<UserDetailResponseDataProduct> products;
	List<String> subCategory;
	List<String> verticals;
}
/*
class UserDetailResponseDataSubCategory with JsonConvert<UserDetailResponseDataSubCategory> {
	int id;
	String name;
}*/

class UserDetailResponseDataProduct with JsonConvert<UserDetailResponseDataProduct> {
	int id;
	String name;
	@JSONField(name: "category_id")
	int categoryId;
	String image;
	@JSONField(name: "user_id")
	int userId;
	String description;
	int moq;
	String price;
	@JSONField(name: "created_at")
	String createdAt;
	@JSONField(name: "updated_at")
	String updatedAt;
}
