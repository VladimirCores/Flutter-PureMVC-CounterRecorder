import 'package:puremvc_counter_recorder_sample/consts/database/DatabaseParamType.dart';

class CounterVO {
  int? id;
  int value = 0;

  CounterVO();

  CounterVO.fromRawValuesIndex(List<Map> rawObjects, {required int index}) {
    this.value = rawObjects[index]['value'];
    this.id = rawObjects[index]['id'];
  }

  static Map<String, String> databaseObjectDescription() {
    return {'value': DatabasePropertyType.INTEGER};
  }

  static Map<String, Object> databaseMapKeyValues(int value) {
    return {'value': value};
  }
}
