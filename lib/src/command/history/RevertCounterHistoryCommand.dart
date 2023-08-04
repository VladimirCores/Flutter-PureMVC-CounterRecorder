import 'dart:async';

import 'package:framework/framework.dart';
import 'package:puremvc_counter_recorder_sample/consts/commands/CounterCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/model/DatabaseProxy.dart';
import 'package:puremvc_counter_recorder_sample/src/model/HistoryProxy.dart';
import 'package:puremvc_counter_recorder_sample/src/model/vos/HistoryVO.dart';

class RevertCounterHistoryCommand extends SimpleCommand {
  @override
  void execute(INotification note) async {
    final int revertToIndex = note.getBody();

    final databaseProxy = facade.retrieveProxy(DatabaseProxy.NAME) as DatabaseProxy;
    final historyProxy = facade.retrieveProxy(HistoryProxy.NAME) as HistoryProxy;

    print("> RevertCounterHistoryCommand > revertToIndex: $revertToIndex");

    final List<HistoryVO> items = historyProxy.getHistoryItemsUntilReverseIndex(revertToIndex);

    print("> RevertCounterHistoryCommand > items: $items");

    items.forEach((HistoryVO item) async => await databaseProxy.deleteItemWithID(
          HistoryVO,
          id: item.id,
        ));

    Timer.periodic(Duration(seconds: 2), (timer) {
      timer.cancel();

      historyProxy.deleteHistoryItemsFromList(items);

      HistoryVO historyVO = historyProxy.getLastHistoryItem();
      sendNotification(CounterCommand.UPDATE, historyVO.value);
    });
  }
}
