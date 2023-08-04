import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    print("> Application -> LoginScreen > initState");
    super.initState();
//		startTime();
  }

//	startTime( ) async {
//		var _duration = Duration( seconds: 2 );
//		return Timer( _duration, navigationPage );
//	}
//
//	void navigationPage() {
//		Navigator.of(context).pushReplacementNamed('/HomePage');
//	}

  @override
  Widget build(BuildContext context) {
    print("> LoginScreen > build");
    return Scaffold(
//			body: Center(
//				child: Image.asset('resources/assets/visual/app_logo.png'),
//			),
        );
  }
}
