import 'package:counter_recorder/consts/Routes.dart';
import 'package:counter_recorder/consts/commands/CounterCommand.dart';
import 'package:counter_recorder/consts/commands/HistoryCommand.dart';
import 'package:counter_recorder/consts/notification/ApplicationNotification.dart';
import 'package:counter_recorder/consts/notification/CounterNotification.dart';
import 'package:counter_recorder/consts/types/CounterHistoryAction.dart';
import 'package:counter_recorder/src/model/vos/CounterVO.dart';
import 'package:counter_recorder/src/view/components/pages/HomePage.dart';
import 'package:framework/framework.dart';

class HomePageMediator extends Mediator {

	static const String NAME = "HomePageMediator";

	static const String SET_COUNTER = "note_home_screen_mediator_set_counter";

	HomePageMediator() : super( NAME );

	@override
	void onRegister() {
		print("> HomePageMediator -> onRegister");
		_homeScreen.onIncrementButtonPressed.listen((time) {
			print("> HomePageMediator -> onIncrementButtonPressed");
			sendNotification( CounterCommand.INCREMENT );
			sendNotification( HistoryCommand.SAVE_COUNTER_HISTORY, CounterHistoryAction.INCREMENT );
		});
		_homeScreen.onDecrementButtonPressed.listen((time) {
			print("> HomePageMediator -> onDecrementButtonPressed");
			sendNotification( CounterCommand.DECREMENT );
			sendNotification( HistoryCommand.SAVE_COUNTER_HISTORY, CounterHistoryAction.DECREMENT );
		});
		_homeScreen.onNavigateHistoryButtonPressed.listen((context) {
			print("> HomePageMediator -> onNavigateHistoryButtonPressed");
			sendNotification( ApplicationNotification.NAVIGATE_TO_PAGE, context, Routes.HISTORY_SCREEN );
		});
	}

	@override
	void onRemove() {

	}

	@override
  List<String> listNotificationInterests() {
    return [
	    CounterNotification.COUNTER_VALUE_UPDATED
    ];
  }

  @override
  void handleNotification(INotification note) {
	  print("> HomePageMediator -> handleNotification: note.name = ${note.getName()}");
	  print("> HomePageMediator -> handleNotification: note.body = ${note.getBody()}");
		switch( note.getName() ) {
			case CounterNotification.COUNTER_VALUE_UPDATED:
				CounterVO valueVO = note.getBody();
				_homeScreen.state.setCounter( valueVO.value );
		}
  }

	HomePage get _homeScreen => getViewComponent() as HomePage;
}