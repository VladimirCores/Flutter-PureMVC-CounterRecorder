import 'package:puremvc_counter_recorder_sample/consts/commands/HistoryCommand.dart';
import 'package:puremvc_counter_recorder_sample/consts/notification/ApplicationNotification.dart';
import 'package:puremvc_counter_recorder_sample/consts/notification/HistoryNotification.dart';
import 'package:puremvc_counter_recorder_sample/src/model/HistoryProxy.dart';
import 'package:puremvc_counter_recorder_sample/src/view/components/pages/HistoryPage.dart';
import 'package:puremvc_counter_recorder_sample/src/view/components/pages/widgets/PageWidget.dart';
import 'package:framework/framework.dart';

class HistoryPageMediator extends Mediator {
  static const String NAME = "HistoryPageMediator";

  static const String SET_COUNTER = "note_home_screen_mediator_set_counter";

  HistoryProxy? _historyProxy;

  HistoryPageMediator() : super(NAME);

  @override
  void onRegister() {
    _historyProxy = facade.retrieveProxy(HistoryProxy.NAME) as HistoryProxy;
    _historyScreen.onStateChanged.listen(handleComponentStateChanged);
    _historyScreen.onRevertHistoryItemButtonPressed.listen((index) {
      print("> HistoryPageMediator -> onRevertHistoryItemButtonPressed: $index");
      sendNotification(HistoryCommand.REVERT_COUNTER_HISTORY, index);
    });
    _historyScreen.onDeleteHistoryItemButtonPressed.listen((index) {
      print("> HistoryPageMediator -> onDeleteHistoryItemBackButtonPressed: $index");
      sendNotification(HistoryCommand.DELETE_COUNTER_HISTORY, index);
    });
    _historyScreen.onNavigationBackButtonPressed.listen((context) {
      print("> HistoryPageMediator -> onIncrementButtonPressed");
      sendNotification(ApplicationNotification.NAVIGATE_TO_BACK, context);
    });

    print("> HistoryPageMediator -> onRegister");
  }

  @override
  void onRemove() {}

  @override
  List<String> listNotificationInterests() {
    return [HistoryNotification.HISTORY_UPDATED];
  }

  @override
  void handleNotification(INotification note) {
    print("> HistoryPageMediator -> handleNotification: note.name = ${note.getName()}");
    switch (note.getName()) {
      case HistoryNotification.HISTORY_UPDATED:
        updateHistoryList(note.getBody() as List<List<String>>);
        break;
    }
  }

  void handleComponentStateChanged(state) {
    print("> HistoryPageMediator -> handleComponentStateChanged: state = $state");
    switch (state) {
      case StateChange.INIT_STATE:
        updateHistoryList(_historyProxy!.getHistoryToDisplay());
        break;
      default:
        break;
    }
  }

  void updateHistoryList(List<List<String>> data) {
    _historyScreen.historyItems = data;
  }

  HistoryPage get _historyScreen => getViewComponent() as HistoryPage;
}
