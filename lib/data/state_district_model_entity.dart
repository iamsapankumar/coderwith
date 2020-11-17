import 'package:badhat_b2b/generated/json/base/json_convert_content.dart';

class StateDistrictModelEntity with JsonConvert<StateDistrictModelEntity> {
	List<StateDistrictModelState> states;
}

class StateDistrictModelState with JsonConvert<StateDistrictModelState> {
	String state;
	List<String> districts;
}
