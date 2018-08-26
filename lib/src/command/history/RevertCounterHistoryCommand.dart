import 'dart:async';

import 'package:counter_recorder/consts/commands/CounterCommand.dart';
import 'package:counter_recorder/src/model/DatabaseProxy.dart';
import 'package:counter_recorder/src/model/HistoryProxy.dart';
import 'package:counter_recorder/src/model/vos/HistoryVO.dart';
import 'package:framework/framework.dart';

class RevertCounterHistoryCommand extends SimpleCommand {
	@override
	void execute( INotification note ) async {

		final int revertToIndex = note.getBody();

		final DatabaseProxy databaseProxy = facade.retrieveProxy( DatabaseProxy.NAME );
		final HistoryProxy historyProxy = facade.retrieveProxy( HistoryProxy.NAME );

		print("> RevertCounterHistoryCommand > revertToIndex: $revertToIndex");

		final List<HistoryVO> items = historyProxy.getHistoryItemsUntilReverseIndex( revertToIndex );

		print("> RevertCounterHistoryCommand > items: $items");

		items.forEach(( HistoryVO item ) async => await databaseProxy.deleteItemWithID( HistoryVO, id: item.id ));

		Timer.periodic(Duration(seconds: 2), (timer) {
			timer.cancel();

			historyProxy.deleteHistoryItemsFromList( items );

			HistoryVO historyVO = historyProxy.getLastHistoryItem();
			sendNotification( CounterCommand.UPDATE, historyVO.value );

		});
	}
}