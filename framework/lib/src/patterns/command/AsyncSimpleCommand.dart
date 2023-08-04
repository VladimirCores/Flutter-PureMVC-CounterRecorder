part of framework;

class AsyncCommand extends SimpleCommand implements IAsyncCommand {
  void setOnComplete(Function value) {
    _onComplete = value;
  }

  void commandComplete() {
    if (_onComplete != null) {
      _onComplete!();
      _onComplete = null;
    }
  }

  Function? _onComplete;
}
