import 'package:counter_recorder/consts/commands/CounterCommand.dart';
import 'package:counter_recorder/src/model/CounterProxy.dart';
import 'package:counter_recorder/src/model/vos/CounterVO.dart';
import 'package:framework/framework.dart';

class IncrementCounterCommand extends SimpleCommand {
	@override
	void execute( INotification note ) async {
		print("> IncrementCounterCommand > note: $note");

		final CounterProxy counterProxy = facade.retrieveProxy( CounterProxy.NAME );
		final CounterVO counterVO = counterProxy.getData();

		final nextValue = counterVO.value + 1;
		this.sendNotification( CounterCommand.UPDATE, nextValue );
	}
}