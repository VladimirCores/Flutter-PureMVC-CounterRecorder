import 'package:counter_recorder/src/command/StartupCommand.dart';
import 'package:counter_recorder/src/command/counter/DecrementCounterCommand.dart';
import 'package:counter_recorder/src/command/counter/IncrementCounterCommand.dart';
import 'package:counter_recorder/src/command/counter/UpdateCounterCommand.dart';
import 'package:counter_recorder/src/command/history/DeleteCounterHistoryCommand.dart';
import 'package:counter_recorder/src/command/history/RevertCounterHistoryCommand.dart';
import 'package:counter_recorder/src/command/history/SaveCounterHistoryCommand.dart';
import 'package:framework/framework.dart';

class Command {
  static ICommand startupCommand() { return new StartupCommand(); }

  // Counter Action Commands
  static ICommand incrementCounterCommand() { return new IncrementCounterCommand(); }
  static ICommand decrementCounterCommand() { return new DecrementCounterCommand(); }
  static ICommand updateCounterCommand() { return new UpdateCounterCommand(); }

  // History Commands
  static ICommand saveCounterHistoryCommand() { return new SaveCounterHistoryCommand(); }
  static ICommand deleteCounterHistoryCommand() { return new DeleteCounterHistoryCommand(); }
  static ICommand revertCounterHistoryCommand() { return new RevertCounterHistoryCommand(); }
}