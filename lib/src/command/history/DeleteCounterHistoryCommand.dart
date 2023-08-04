import 'package:framework/framework.dart';
import 'package:puremvc_counter_recorder_sample/consts/commands/CounterCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/model/DatabaseProxy.dart';
import 'package:puremvc_counter_recorder_sample/src/model/HistoryProxy.dart';
import 'package:puremvc_counter_recorder_sample/src/model/vos/HistoryVO.dart';

class DeleteCounterHistoryCommand extends SimpleCommand {
  @override
  void execute(INotification note) async {
    final int index = note.getBody();

    print("> DeleteCounterHistoryCommand > index: $index");

    final databaseProxy = facade.retrieveProxy(DatabaseProxy.NAME) as DatabaseProxy;
    final historyProxy = facade.retrieveProxy(HistoryProxy.NAME) as HistoryProxy;

    final HistoryVO historyVO = historyProxy.getHistoryItemAtReverseIndex(index);

    print("> DeleteCounterHistoryCommand > historyVO.id: ${historyVO.id}");
    await databaseProxy.deleteItemWithID(HistoryVO, id: historyVO.id);

    historyProxy.deleteHistoryItem(historyVO);

    if (index == 0) {
      final counterUpdateValue = historyProxy.itemsInHistory > 0 ? historyProxy.getLastHistoryItem().value : 0;
      sendNotification(CounterCommand.UPDATE, counterUpdateValue);
    }
  }
}
