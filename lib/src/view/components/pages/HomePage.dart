import 'dart:async';
import 'package:counter_recorder/src/view/components/pages/widgets/PageWidget.dart';
import 'package:flutter/material.dart';

class HomePage extends ScreenWidget
{
	HomePage({ Key key, this.title }) : super( key: Key("HomePage") );

	final String title;

	final state = new _HomePageState();

	final StreamController _decrementButtonPressed = StreamController.broadcast();
	final StreamController _incrementButtonPressed = StreamController.broadcast();
	final StreamController _navigateHistoryButtonPressed = StreamController.broadcast();

	Stream get onIncrementButtonPressed => _incrementButtonPressed.stream;
	Stream get onDecrementButtonPressed => _decrementButtonPressed.stream;
	Stream get onNavigateHistoryButtonPressed => _navigateHistoryButtonPressed.stream;

	@override
	_HomePageState createState() => state;
}

class _HomePageState extends RouterState<HomePage>
{
	int counter = 0;

	void _incrementCounter() {
		print("> HomePage -> incrementCounter");
		widget._incrementButtonPressed.add( context );
	}

	void _decrementCounter() {
		print("> HomePage -> decrementCounter");
		widget._decrementButtonPressed.add( context );
	}

	void _navigateToHistory( context ) {
		print("> HomePage -> navigateToHistory");
		widget._navigateHistoryButtonPressed.add( context );
	}

	void setCounter( int value ) {
		counter = value;
		if(this.mounted)
			setState(() { });
	}

	@override
	Widget build( BuildContext context ) {
		print("> HomePage -> build");
		return new Scaffold(
			appBar: new AppBar(
				title: new Text( widget.title ),
				actions: <Widget>[
					new IconButton(
						icon: new Icon(Icons.history),
						tooltip: 'History',
						onPressed: () => _navigateToHistory( context )
					),
				],
			),
			body: new Center(
				child: new Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						new Text(
							'COUTNER VALUE:',
						),
						new Text(
							'$counter',
							style: Theme.of( context ).textTheme.display3,
						),
					],
				),
			),
			floatingActionButton: new Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					mainAxisSize: MainAxisSize.min,
					children: [
						new FloatingActionButton(
							heroTag: "heroTagIncrement",
							onPressed: _incrementCounter,
							tooltip: 'Increment',
							child: new Icon( Icons.add ),
						),
						new Padding(padding: new EdgeInsets.all(8.0)),
						new FloatingActionButton(
							heroTag: "heroTagDecrement",
							onPressed: _decrementCounter,
							tooltip: 'Decrement',
							child: new Icon( Icons.remove ),
						)
					]
				),
		);
	}
}
