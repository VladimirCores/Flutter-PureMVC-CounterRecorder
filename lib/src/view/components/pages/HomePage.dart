import 'dart:async';

import 'package:puremvc_counter_recorder_sample/src/view/components/pages/widgets/PageWidget.dart';
import 'package:flutter/material.dart';

class HomePage extends ScreenWidget {
  HomePage({
    required this.title,
  }) : super(key: Key("HomePage"));

  final String title;

  final state = _HomePageState();

  final StreamController _decrementButtonPressed = StreamController.broadcast();
  final StreamController _incrementButtonPressed = StreamController.broadcast();
  final StreamController _navigateHistoryButtonPressed = StreamController.broadcast();

  Stream get onIncrementButtonPressed => _incrementButtonPressed.stream;
  Stream get onDecrementButtonPressed => _decrementButtonPressed.stream;
  Stream get onNavigateHistoryButtonPressed => _navigateHistoryButtonPressed.stream;

  @override
  _HomePageState createState() => state;
}

class _HomePageState extends RouterState<HomePage> {
  int counter = 0;

  void _incrementCounter() {
    print("> HomePage -> incrementCounter");
    widget._incrementButtonPressed.add(context);
  }

  void _decrementCounter() {
    print("> HomePage -> decrementCounter");
    widget._decrementButtonPressed.add(context);
  }

  void _navigateToHistory(context) {
    print("> HomePage -> navigateToHistory");
    widget._navigateHistoryButtonPressed.add(context);
  }

  void setCounter(int value) {
    counter = value;
    if (this.mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("> HomePage -> build");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.history), tooltip: 'History', onPressed: () => _navigateToHistory(context)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'COUTNER VALUE:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ),
      floatingActionButton:
          Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        FloatingActionButton(
          heroTag: "heroTagIncrement",
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        Padding(padding: EdgeInsets.all(8.0)),
        FloatingActionButton(
          heroTag: "heroTagDecrement",
          onPressed: _decrementCounter,
          tooltip: 'Decrement',
          child: Icon(Icons.remove),
        )
      ]),
    );
  }
}
