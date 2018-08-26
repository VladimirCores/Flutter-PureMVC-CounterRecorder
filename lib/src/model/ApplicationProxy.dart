import 'package:framework/framework.dart';

class ApplicationProxy extends Proxy {
  static const String NAME = "ApplicationProxy";

  ApplicationProxy() : super( NAME ) {
	  print(">\t ApplicationProxy -> instance created");
  }

  @override
  void onRegister() {
	  print(">\t ApplicationProxy -> onRegister");
  }

  @override
  void onRemove() {

  }
}