import 'package:badhat_b2b/generated/json/base/json_convert_content.dart';
import 'package:badhat_b2b/generated/json/base/json_filed.dart';

class SearchResultEntity with JsonConvert<SearchResultEntity> {
	List<SearchResultData> data;
	String message;
}

class SearchResultData with JsonConvert<SearchResultData> {
	int id;
	String name;
	String email;
	dynamic image;
	@JSONField(name: "business_name")
	String businessName;
	String mobile;
	String state;
	String district;
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
}
