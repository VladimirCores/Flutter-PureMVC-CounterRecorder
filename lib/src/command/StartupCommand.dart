import 'package:counter_recorder/src/command/ReadyCommand.dart';
import 'package:counter_recorder/src/command/prepare/PrepareCompleteCommand.dart';
import 'package:counter_recorder/src/command/prepare/PrepareModelCommand.dart';
import 'package:counter_recorder/src/command/prepare/PrepareViewCommand.dart';
import 'package:counter_recorder/src/command/prepare/PrepareControllerCommand.dart';
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
  void execute( INotification note ) {
    print( "> StartupCommand -> note : $note" );
    super.execute( note );
  }
}
