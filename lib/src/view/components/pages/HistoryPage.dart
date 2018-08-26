import 'dart:async';

import 'package:counter_recorder/src/view/components/pages/widgets/PageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HistoryPage extends ScreenWidget
{
	HistoryPage({ Key key, this.title }) : super( key: Key("HistoryPage") );

	final String title;
	_HistoryPageState state;

	set historyItems( List<List<String>> values ) {
		state.setHistoryItems( values );
		state.setLoading( false );
	}

	final StreamController _navigateBackButtonPressed = StreamController.broadcast();
	final StreamController _deleteHistoryItemConfirmed = StreamController.broadcast();
	final StreamController _revertHistoryItemConfirmed = StreamController.broadcast();

	Stream get onNavigationBackButtonPressed => _navigateBackButtonPressed.stream;
	Stream get onDeleteHistoryItemButtonPressed => _deleteHistoryItemConfirmed.stream;
	Stream get onRevertHistoryItemButtonPressed => _revertHistoryItemConfirmed.stream;

	@override
	_HistoryPageState createState() => state = _HistoryPageState();

	void _showDialogConfirmRevertToIndex( context, String value, int index ) async {
		if( await showDialog( context: context,
			builder: (BuildContext context) => _TwoButtonsAlertDialog.create( context,
				title: "Confirm revert?",
				content:"Reverting state to $value value will remove all history before that action."
			)
		)) {
			state.setLoading( true );
			_revertHistoryItemConfirmed.add( index );
		}
	}

	void _showDialogConfirmDeleteAtIndex( context, String value, String action, int index ) async {
		if( await showDialog( context: context,
			builder: (BuildContext context) => _TwoButtonsAlertDialog.create( context,
				title: "Confirm delete?",
				content: "Do you want delete history item with value $value and action $action."
			)
		)) {
			state.setLoading( true );
			_deleteHistoryItemConfirmed.add( index );
		}
	}
}

class _HistoryPageState extends RouterState<HistoryPage> with RouteAware
{
	bool loading = true;
	List<List<String>> historyItems = [];

	@override
	void dispose() {
		historyItems = null;
		super.dispose();
	}

	void setHistoryItems( List<List<String>> values ) {
		print("> HistoryPage -> setHistoryItems: values = $values");
		historyItems = values;
		if( mounted ) setState(() {});
	}

	void setLoading(bool value) {
		loading = value;
		if( mounted ) setState(() {});
	}

	@override
	Widget build( BuildContext context ) {
		print("> HistoryPage -> build");

		List<Widget> body = [];
		if( loading ) {
			body.add( Container(
				color: Colors.grey,
				child: Center(child: CircularProgressIndicator()),
			));
		}

		body.add( ListView.builder(
			itemCount: historyItems.length,
			itemBuilder: ( context, index ) {
				var historyItem = historyItems[ index ];
				String value = historyItem[2];
				String time = historyItem[1];
				String action = historyItem[0];
				return ListTile(
					selected: index == 0,
					trailing: new IconButton(
							icon: new Icon( Icons.delete ),
							tooltip: 'Delete',
							onPressed: () => widget._showDialogConfirmDeleteAtIndex( context, value, action, index )
					),
					leading: new IconButton(
							icon: new Icon( Icons.refresh ),
							tooltip: 'Restore',
							onPressed: index != 0 ? () => widget._showDialogConfirmRevertToIndex( context, value, index ) : null
					),
					title: Text('Value: $value ($action)'),
					subtitle: Text( '$time' ),
				);
			},
		));

		return new Scaffold(
			appBar: new AppBar(
				title: new Text( widget.title ),
				leading:
					new IconButton(
						icon: new Icon( Icons.arrow_back ),
						tooltip: 'Back',
						onPressed: () => widget._navigateBackButtonPressed.add( context )
					),
			),
			body: Stack( children: body )
		);
	}
}

class _TwoButtonsAlertDialog {
	static AlertDialog create(context, {String title, String content}) {
		return AlertDialog(
			title: new Text(title),
			content: new Text(content),
			actions: <Widget>[
				// usually buttons at the bottom of the dialog
				new FlatButton(
					child: new Text("Confirm"),
					onPressed: () {
						Navigator.of(context).pop(true);
					},
				),
				new FlatButton(
					child: new Text("Close"),
					onPressed: () {
						Navigator.of(context).pop(false);
					},
				),
			],
		);
	}
}