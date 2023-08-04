import 'package:framework/framework.dart';
import 'package:puremvc_counter_recorder_sample/src/controller/commands/ReadyCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/controller/commands/prepare/PrepareCompleteCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/controller/commands/prepare/PrepareControllerCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/controller/commands/prepare/PrepareModelCommand.dart';
import 'package:puremvc_counter_recorder_sample/src/controller/commands/prepare/PrepareViewCommand.dart';

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
