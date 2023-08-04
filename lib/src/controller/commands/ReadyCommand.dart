import 'package:puremvc_counter_recorder_sample/src/view/components/Application.dart';
import 'package:flutter/material.dart';
import 'package:framework/framework.dart';

class ReadyCommand extends SimpleCommand {
  @override
  void execute(INotification note) {
    print("> StartupCommand -> ReadyCommand > note: $note");

    final app = note.getBody() as Application;

    runApp(app);
  }
}
