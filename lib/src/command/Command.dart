import 'package:puremvc_counter_recorder_sample/src/command/StartupCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/command/counter/DecrementCounterCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/command/counter/IncrementCounterCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/command/counter/UpdateCounterCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/command/history/DeleteCounterHistoryCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/command/history/RevertCounterHistoryCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/command/history/SaveCounterHistoryCommand.dart';
import 'package:framework/framework.dart';

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
