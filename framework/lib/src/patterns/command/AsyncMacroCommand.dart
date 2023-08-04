part of framework;

class AsyncMacroCommand extends Notifier implements IAsyncCommand {
  Function? _onComplete;
  late List<Function>? _subCommands;
  INotification? _note;
  int _counter = 0;

  AsyncMacroCommand() {
    _subCommands = List<Function>.empty(growable: true);
  }

  void addSubCommand(Function commandClassRef) {
    _subCommands!.add(commandClassRef);
  }

  void addSubCommands(List<Function> classes) {
    _subCommands!.addAll(classes);
  }

  void execute(INotification note) {
    _note = note;
    _executeNextCommand();
  }

  void setOnComplete(Function value) {
    _onComplete = value;
  }

  @override
  void initializeNotifier(String key) {
    super.initializeNotifier(key);
    _initializeAsyncMacroCommand();
  }

  void _initializeAsyncMacroCommand() {}
  void _deInitializeAsyncMacroCommand() {
    _subCommands!.clear();
    _subCommands = null;
    _onComplete = null;
    _note = null;
  }

  void _executeNextCommand() {
//		print("> Framework -> AsyncMacroCommand -> executeNextCommand: _counter = ${_counter}");
    if (_subCommands!.length > _counter)
      _nextCommand();
    else {
      if (_onComplete != null) _onComplete!();
      _deInitializeAsyncMacroCommand();
    }
  }

  void _nextCommand() {
    final String multitonKey = getMultitonKey()!;

    Function commandFactory = _subCommands![_counter++];
    ICommand commandInstance = commandFactory();
    bool isAsync = commandInstance is IAsyncCommand;

    commandInstance.initializeNotifier(multitonKey);
    if (isAsync) commandInstance.setOnComplete(_executeNextCommand);

    commandInstance.execute(_note!);
    if (!isAsync) _executeNextCommand();
  }
}
