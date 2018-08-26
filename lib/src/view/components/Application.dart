import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  // This widget is the root of your application.

	final Map<String, WidgetBuilder> routes;
	final List<NavigatorObserver> observers;
	final String initialRoute;

	Application({
    @required this.routes,
    @required this.observers,
    @required this.initialRoute
	});

  @override
  Widget build( BuildContext context ) {
  	print("> Application -> build");
    return new MaterialApp(
	    routes: routes,
	    navigatorObservers: observers,
	    initialRoute: initialRoute,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      )
    );
  }
}
