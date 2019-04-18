import 'package:counter_recorder/consts/commands/CounterCommand.dart';
import 'package:counter_recorder/src/model/CounterProxy.dart';
import 'package:counter_recorder/src/model/vos/CounterVO.dart';
import 'package:framework/framework.dart';

class DecrementCounterCommand extends SimpleCommand {
	@override
	void execute( INotification note ) async {
		print("> DecrementCounterCommand > note: $note");

		final CounterProxy counterProxy = facade.retrieveProxy( CounterProxy.NAME );
		final CounterVO counterVO = counterProxy.getData();

		if (counterVO.value > 0)
		{
			final nextValue = counterVO.value - 1;
			this.sendNotification( CounterCommand.UPDATE, nextValue );
		}
		else
		{

		}
	}
}