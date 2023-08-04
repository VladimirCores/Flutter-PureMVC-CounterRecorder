import 'package:puremvc_counter_recorder_sample/src/command/ReadyCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/command/prepare/PrepareCompleteCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/command/prepare/PrepareControllerCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/command/prepare/PrepareModelCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/command/prepare/PrepareViewCommand.dart';
import 'package:framework/framework.dart';

class StartupCommand extends AsyncMacroCommand {
  static const String NAME = "StartupCommand";

  StartupCommand() {
    addSubCommands([
      () => PrepareModelCommand(),
      () => PrepareControllerCommand(),
      () => PrepareViewCommand(),
      () => PrepareCompleteCommand(),
      () => ReadyCommand()
    ]);
  }

  @override
  void execute(INotification note) {
    print("> StartupCommand -> note : $note");
    super.execute(note);
  }
}
