import 'package:puremvc_counter_recorder_sample/src/model/CounterProxy.dart';
import 'package:puremvc_counter_recorder_sample/src/model/DatabaseProxy.dart';
import 'package:puremvc_counter_recorder_sample/src/model/HistoryProxy.dart';
import 'package:puremvc_counter_recorder_sample/src/model/vos/CounterVO.dart';
import 'package:puremvc_counter_recorder_sample/src/model/vos/HistoryVO.dart';
import 'package:framework/framework.dart';

class SaveCounterHistoryCommand extends SimpleCommand {
  @override
  void execute(INotification note) async {
    print("> SaveCounterHistoryCommand > note: ${note.getBody().toString()}");

    final int time = DateTime.now().toUtc().millisecondsSinceEpoch;
    final String type = note.getBody();

    print("> SaveCounterHistoryCommand > time: $time");
    print("> SaveCounterHistoryCommand > type: $type");

    final databaseProxy = facade.retrieveProxy(DatabaseProxy.NAME) as DatabaseProxy;
    final counterProxy = facade.retrieveProxy(CounterProxy.NAME) as CounterProxy;
    final historyProxy = facade.retrieveProxy(HistoryProxy.NAME) as HistoryProxy;

    final CounterVO counterVO = counterProxy.getData() as CounterVO;

    final HistoryVO historyVO = HistoryVO.fromValues(time, counterVO.value, type);

    await databaseProxy.insertVO(HistoryVO, HistoryVO.databaseMapKeyValues(historyVO));

    historyProxy.addHistoryItem(historyVO);

    print("> SaveCounterHistoryCommand > Completed");
  }
}
