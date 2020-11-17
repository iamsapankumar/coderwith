import 'package:badhat_b2b/data/state_district_model_entity.dart';

stateDistrictModelEntityFromJson(StateDistrictModelEntity data, Map<String, dynamic> json) {
	if (json['states'] != null) {
		data.states = new List<StateDistrictModelState>();
		(json['states'] as List).forEach((v) {
			data.states.add(new StateDistrictModelState().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> stateDistrictModelEntityToJson(StateDistrictModelEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.states != null) {
		data['states'] =  entity.states.map((v) => v.toJson()).toList();
	}
	return data;
}

stateDistrictModelStateFromJson(StateDistrictModelState data, Map<String, dynamic> json) {
	if (json['state'] != null) {
		data.state = json['state']?.toString();
	}
	if (json['districts'] != null) {
		data.districts = json['districts']?.map((v) => v?.toString())?.toList()?.cast<String>();
	}
	return data;
}

Map<String, dynamic> stateDistrictModelStateToJson(StateDistrictModelState entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['state'] = entity.state;
	data['districts'] = entity.districts;
	return data;
}