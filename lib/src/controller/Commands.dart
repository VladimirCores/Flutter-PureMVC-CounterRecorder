import 'package:framework/framework.dart';
import 'package:puremvc_counter_recorder_sample/src/controller/commands/StartupCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/controller/commands/counter/DecrementCounterCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/controller/commands/counter/IncrementCounterCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/controller/commands/counter/UpdateCounterCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/controller/commands/history/DeleteCounterHistoryCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/controller/commands/history/RevertCounterHistoryCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/controller/commands/history/SaveCounterHistoryCommand.dart';

class Command {
  static ICommand startupCommand() {
    return StartupCommand();
  }

  // Counter Action Commands
  static ICommand incrementCounterCommand() {
    return IncrementCounterCommand();
  }

  static ICommand decrementCounterCommand() {
    return DecrementCounterCommand();
  }

  static ICommand updateCounterCommand() {
    return UpdateCounterCommand();
  }

  // History Commands
  static ICommand saveCounterHistoryCommand() {
    return SaveCounterHistoryCommand();
  }

  static ICommand deleteCounterHistoryCommand() {
    return DeleteCounterHistoryCommand();
  }

  static ICommand revertCounterHistoryCommand() {
    return RevertCounterHistoryCommand();
  }
}
