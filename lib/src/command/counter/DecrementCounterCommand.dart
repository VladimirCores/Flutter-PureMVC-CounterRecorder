import 'package:puremvc_counter_recorder_sample/consts/commands/CounterCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/model/CounterProxy.dart';
import 'package:puremvc_counter_recorder_sample/src/model/vos/CounterVO.dart';
import 'package:framework/framework.dart';

class DecrementCounterCommand extends SimpleCommand {
	@override
	void execute( INotification note ) async {
		print("> DecrementCounterCommand > note: $note");

		final counterProxy = facade.retrieveProxy( CounterProxy.NAME ) as CounterProxy;
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