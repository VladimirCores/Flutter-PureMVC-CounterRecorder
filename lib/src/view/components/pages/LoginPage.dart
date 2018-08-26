import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget
{
	@override
	_LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

	@override
	void initState() {
		print("> Application -> LoginScreen > initState");
		super.initState();
//		startTime();
	}

//	startTime( ) async {
//		var _duration = new Duration( seconds: 2 );
//		return new Timer( _duration, navigationPage );
//	}
//
//	void navigationPage() {
//		Navigator.of(context).pushReplacementNamed('/HomePage');
//	}

	@override
	Widget build(BuildContext context) {
		print("> LoginScreen > build");
		return new Scaffold(
//			body: new Center(
//				child: Image.asset('resources/assets/visual/app_logo.png'),
//			),
		);
	}
}