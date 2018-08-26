import 'dart:async';
import 'package:flutter/widgets.dart';

abstract class ScreenWidget extends StatefulWidget
{
	ScreenWidget({ Key key }) : super( key: key );

	final StreamController _routingStateController = StreamController.broadcast();
	final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();

	Stream get onStateChanged => _routingStateController.stream;
}

abstract class RouterState<T extends ScreenWidget> extends State<T> with RouteAware
{
	@override
	void initState() {
		super.initState();
		widget._routingStateController.add( StateChange.INIT_STATE );
	}

	@override
	void dispose() {
		widget.routeObserver.unsubscribe( this );
		print("> $runtimeType -> dispose");
		widget._routingStateController.add( StateChange.DISPOSE );
		super.dispose();
	}

	@override
	void didChangeDependencies() {
		super.didChangeDependencies();
		print("> $runtimeType -> didChangeDependencies: mounted = ${this.mounted}");
		widget.routeObserver.subscribe( this, ModalRoute.of( context ) );
		widget._routingStateController.add( StateChange.DID_CHANGE_DEPENDENCIES );
	}

	// Called when the top route has been popped off, and the current route shows up.
	@override
	void didPopNext() {
		print("> $runtimeType -> didPopNext");
		widget._routingStateController.add( StateChange.DID_POP_NEXT );
		super.didPopNext();
	}

	// Called when a new route has been pushed, and the current route is no longer visible.
	@override
	void didPushNext() {
		print("> $runtimeType -> didPushNext");
		widget._routingStateController.add( StateChange.DID_PUSH_NEXT );
		super.didPushNext();
	}

	// Called when the current route has been pushed.
	@override
	void didPush() {
		print("> $runtimeType -> didPush");
		widget._routingStateController.add( StateChange.DID_PUSH );
		super.didPush();
	}

	// Called when the current route has been popped off.
	@override
	void didPop() {
		print("> $runtimeType -> didPop");
		widget._routingStateController.add( StateChange.DID_POP );
		super.didPop();
	}
}

enum StateChange {
	DID_CHANGE_DEPENDENCIES,
	DID_POP_NEXT,
	DID_PUSH_NEXT,
	DID_COMPLETE,
	DID_REPLACE,
	DID_PUSH,
	DID_POP,
	INIT_STATE,
	DISPOSE
}