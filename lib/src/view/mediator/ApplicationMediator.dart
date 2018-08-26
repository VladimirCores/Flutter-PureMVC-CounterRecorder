import 'package:counter_recorder/consts/notification/ApplicationNotification.dart';
import 'package:counter_recorder/src/view/components/Application.dart';
import 'package:flutter/material.dart';
import 'package:framework/framework.dart';

class ApplicationMediator extends Mediator {

	static const String NAME = "ApplicationMediator";

	static const String SET_COUNTER = "note_application_mediator_set_counter";

	ApplicationMediator() : super( NAME );

	@override
	void onRegister() {
		print(">\t ApplicationMediator -> onRegister");
	}

	@override
	void onRemove() {

	}

	@override
	List<String> listNotificationInterests() {
		return [
			ApplicationNotification.NAVIGATE_TO_PAGE
		,	ApplicationNotification.NAVIGATE_TO_BACK
		];
	}

	@override
	void handleNotification( INotification note ) {
		print("> ApplicationMediator -> handleNotification: note.name = ${note.getName()}");
		switch( note.getName() ) {
			case ApplicationNotification.NAVIGATE_TO_BACK:
				final BuildContext context = note.getBody();
				Navigator.pop( context );
				break;
			case ApplicationNotification.NAVIGATE_TO_PAGE:
				final BuildContext context = note.getBody();
				final String routeName = note.getType();
				Navigator.of( context ).pushNamed( routeName );
				break;
		}
	}

	Application get application => getViewComponent() as Application;
}