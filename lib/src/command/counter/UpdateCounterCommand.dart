import 'package:counter_recorder/src/model/CounterProxy.dart';
import 'package:counter_recorder/src/model/DatabaseProxy.dart';
import 'package:counter_recorder/src/model/vos/CounterVO.dart';
import 'package:framework/framework.dart';

class UpdateCounterCommand extends SimpleCommand {
	@override
	void execute( INotification note ) async {
		print("> UpdateCounterCommand > note: $note");
		int value = note.getBody();

		final DatabaseProxy databaseProxy = facade.retrieveProxy( DatabaseProxy.NAME );
		final CounterProxy counterProxy = facade.retrieveProxy( CounterProxy.NAME );

		final CounterVO counterVO = counterProxy.getData();
		counterVO.value = value;

		await databaseProxy.updateVO( CounterVO,
				params: CounterVO.databaseMapKeyValues( counterVO.value ),
				id: counterVO.id
		);

		counterProxy.setData( counterVO );
	}
}