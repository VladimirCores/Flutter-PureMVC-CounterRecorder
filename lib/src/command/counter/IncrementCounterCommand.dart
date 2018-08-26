import 'package:counter_recorder/src/model/CounterProxy.dart';
import 'package:counter_recorder/src/model/DatabaseProxy.dart';
import 'package:counter_recorder/src/model/vos/CounterVO.dart';
import 'package:framework/framework.dart';

class IncrementCounterCommand extends SimpleCommand {
	@override
	void execute( INotification note ) async {
		print("> IncrementCounterCommand > note: $note");

		final DatabaseProxy databaseProxy = facade.retrieveProxy( DatabaseProxy.NAME );
		final CounterProxy counterProxy = facade.retrieveProxy( CounterProxy.NAME );

		final CounterVO counterVO = counterProxy.getData();
		counterVO.value += 1;

		await databaseProxy.updateVO( CounterVO,
			params: CounterVO.databaseMapKeyValues( counterVO.value ),
			id: counterVO.id
		);

		counterProxy.setData( counterVO );
	}
}