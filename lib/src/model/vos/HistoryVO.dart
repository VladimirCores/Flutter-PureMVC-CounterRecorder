import 'package:puremvc_counter_recorder_sample/consts/database/DatabaseParamType.dart';

class HistoryVO {
  int? id;
  int time = 0;
  int value = 0;
  String action = "";

  HistoryVO.fromValues(this.time, this.value, this.action);

  HistoryVO.fromRawValues(Map rawValue) {
    this.action = rawValue['action'];
    this.value = rawValue['value'];
    this.time = rawValue['time'];
    this.id = rawValue['id'];
  }

  static Map<String, String> databaseObjectDescription() {
    return {
      'time': DatabasePropertyType.INTEGER,
      'value': DatabasePropertyType.INTEGER,
      'action': DatabasePropertyType.TEXT
    };
  }

  static Map<String, Object> databaseMapKeyValues(HistoryVO input) {
    return {'time': input.time, 'value': input.value, 'action': input.action};
  }
}
