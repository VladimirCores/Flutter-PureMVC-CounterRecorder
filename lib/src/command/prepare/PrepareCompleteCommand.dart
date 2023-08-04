import 'dart:async';

import 'package:framework/framework.dart';
import 'package:puremvc_counter_recorder_sample/src/model/ApplicationProxy.dart';
import 'package:puremvc_counter_recorder_sample/src/model/CounterProxy.dart';
import 'package:puremvc_counter_recorder_sample/src/model/DatabaseProxy.dart';
import 'package:puremvc_counter_recorder_sample/src/model/HistoryProxy.dart';
import 'package:puremvc_counter_recorder_sample/src/model/vos/CounterVO.dart';
import 'package:puremvc_counter_recorder_sample/src/model/vos/HistoryVO.dart';

class PrepareCompleteCommand extends AsyncCommand {
  @override
  Future execute(INotification note) async {
    print("> StartupCommand -> PrepareCompleteCommand > execute");

    final databaseProxy = facade.retrieveProxy(DatabaseProxy.NAME) as DatabaseProxy;
    final applicationProxy = facade.retrieveProxy(ApplicationProxy.NAME) as ApplicationProxy;
    final counterProxy = facade.retrieveProxy(CounterProxy.NAME) as CounterProxy;
    final historyProxy = facade.retrieveProxy(HistoryProxy.NAME) as HistoryProxy;

    CounterVO valueVO = await retrieveCounterValueFromDatabase(databaseProxy);
    List<HistoryVO> history = await retrieveHistoryFromDatabase(databaseProxy);

    counterProxy.setData(valueVO);
    historyProxy.setData(history);

    print("> StartupCommand -> PrepareCompleteCommand > valueVO.value = ${valueVO.value}");
    print("> StartupCommand -> PrepareCompleteCommand > history = $history");

    commandComplete();
  }

  Future<CounterVO> retrieveCounterValueFromDatabase(DatabaseProxy databaseProxy) async {
    CounterVO result;
    List<Map> rawValues = await databaseProxy.retrieveVO(CounterVO);
    if (rawValues.length == 0) {
      result = CounterVO();
      databaseProxy.insertVO(CounterVO, CounterVO.databaseMapKeyValues(result.value));
    } else {
      result = CounterVO.fromRawValuesIndex(rawValues, index: 0);
    }
    return result;
  }

  Future<List<HistoryVO>> retrieveHistoryFromDatabase(DatabaseProxy databaseProxy) async {
    List<HistoryVO> result = List<HistoryVO>.empty(growable: true);
    List<Map> rawValues = await databaseProxy.retrieve(HistoryVO);
    print("> StartupCommand -> PrepareCompleteCommand > RetrieveHistoryFromDatabase : rawValues = $rawValues");
    rawValues.forEach((Map rawValue) => result.add(HistoryVO.fromRawValues(rawValue)));
    return result;
  }
}
