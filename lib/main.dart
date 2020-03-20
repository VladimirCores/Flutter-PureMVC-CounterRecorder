import 'package:counter_recorder/src/command/Command.dart';
import 'package:counter_recorder/src/command/StartupCommand.dart';
import 'package:flutter/widgets.dart';
import 'src/ApplicationFacade.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final applicationFacade = ApplicationFacade.getInstance( ApplicationFacade.CORE );
  applicationFacade.registerCommand( StartupCommand.NAME, Command.startupCommand );
  applicationFacade.executeCommand( StartupCommand.NAME );
}
