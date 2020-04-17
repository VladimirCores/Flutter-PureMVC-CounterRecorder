import 'package:counter_recorder/consts/Routes.dart';
import 'package:counter_recorder/src/view/components/Application.dart';
import 'package:counter_recorder/src/view/components/pages/HistoryPage.dart';
import 'package:counter_recorder/src/view/components/pages/HomePage.dart';
import 'package:counter_recorder/src/view/components/pages/LoginPage.dart';
import 'package:counter_recorder/src/view/mediator/ApplicationMediator.dart';
import 'package:counter_recorder/src/view/mediator/pages/HistoryPageMediator.dart';
import 'package:counter_recorder/src/view/mediator/pages/HomePageMediator.dart';
import 'package:flutter/material.dart';
import 'package:framework/framework.dart';

class PrepareViewCommand extends SimpleCommand {
  @override
  void execute( INotification note ) {
    print("> StartupCommand -> PrepareViewCommand > note: $note");

    final ApplicationMediator applicationMediator = ApplicationMediator();
    final HomePageMediator homeScreenMediator = HomePageMediator();
    final HistoryPageMediator historyScreenMediator = HistoryPageMediator();

    final HomePage homePage = HomePage( title: 'Counter Recorder' );
    final LoginScreen loginPage = LoginScreen();
    final HistoryPage historyPAge = HistoryPage( title: 'History' );

    final Application application = new Application(
      observers: <NavigatorObserver>[
      	homePage.routeObserver
	    , historyPAge.routeObserver
      ],
		  routes: {
			  Routes.HOME_SCREEN: ( BuildContext context ) => homePage,
			  Routes.LOGIN_SCREEN: ( BuildContext context ) => loginPage,
			  Routes.HISTORY_SCREEN: ( BuildContext context ) => historyPAge,
		  },
		  initialRoute: Routes.HOME_SCREEN
	  );

    applicationMediator.setViewComponent( application );
    homeScreenMediator.setViewComponent( homePage );
    historyScreenMediator.setViewComponent( historyPAge );

    facade.registerMediator( applicationMediator );
    facade.registerMediator( homeScreenMediator );
    facade.registerMediator( historyScreenMediator );

    note.setBody( application );
  }
}