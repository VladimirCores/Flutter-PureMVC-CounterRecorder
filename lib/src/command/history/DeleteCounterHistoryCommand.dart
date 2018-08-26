import 'package:counter_recorder/consts/commands/CounterCommand.dart';
import 'package:counter_recorder/src/model/DatabaseProxy.dart';
import 'package:counter_recorder/src/model/HistoryProxy.dart';
import 'package:counter_recorder/src/model/vos/HistoryVO.dart';
import 'package:framework/framework.dart';

class DeleteCounterHistoryCommand extends SimpleCommand {
	@override
	void execute( INotification note ) async {
		final int index = note.getBody();

		print("> DeleteCounterHistoryCommand > index: $index");

		final DatabaseProxy databaseProxy = facade.retrieveProxy( DatabaseProxy.NAME );
		final HistoryProxy historyProxy = facade.retrieveProxy( HistoryProxy.NAME );

		final HistoryVO historyVO = historyProxy.getHistoryItemAtReverseIndex( index );

		print("> DeleteCounterHistoryCommand > historyVO.id: ${historyVO.id}");
		await databaseProxy.deleteItemWithID( HistoryVO, id: historyVO.id );

		historyProxy.deleteHistoryItem( historyVO );

		if( index == 0 ) {
			final counterUpdateValue = historyProxy.itemsInHistory > 0 ? historyProxy.getLastHistoryItem().value : 0;
			sendNotification( CounterCommand.UPDATE, counterUpdateValue );
		}
	}
}