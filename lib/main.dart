import 'package:flutter/widgets.dart';
import 'package:puremvc_counter_recorder_sample/src/controller/Commands.dart';
import 'package:puremvc_counter_recorder_sample/src/controller/commands/StartupCommand.dart';

import 'src/ApplicationFacade.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final applicationFacade = ApplicationFacade.getInstance(ApplicationFacade.CORE);
  applicationFacade.registerCommand(StartupCommand.NAME, Command.startupCommand);
  applicationFacade.executeCommand(StartupCommand.NAME);
}
