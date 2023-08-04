import 'package:framework/framework.dart';
import 'package:puremvc_counter_recorder_sample/consts/commands/CounterCommand.dart';
import 'package:puremvc_counter_recorder_sample/consts/commands/HistoryCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/controller/Commands.dart';

class PrepareControllerCommand extends SimpleCommand {
  @override
  void execute(INotification note) {
    print("> StartupCommand -> PrepareControllerCommand > note: $note");

    facade.registerCommand(CounterCommand.INCREMENT, Command.incrementCounterCommand);
    facade.registerCommand(CounterCommand.DECREMENT, Command.decrementCounterCommand);
    facade.registerCommand(CounterCommand.UPDATE, Command.updateCounterCommand);

    facade.registerCommand(HistoryCommand.SAVE_COUNTER_HISTORY, Command.saveCounterHistoryCommand);
    facade.registerCommand(HistoryCommand.DELETE_COUNTER_HISTORY, Command.deleteCounterHistoryCommand);
    facade.registerCommand(HistoryCommand.REVERT_COUNTER_HISTORY, Command.revertCounterHistoryCommand);
  }
}
