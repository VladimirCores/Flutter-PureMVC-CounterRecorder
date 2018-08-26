import 'package:counter_recorder/consts/notification/CounterNotification.dart';
import 'package:counter_recorder/src/model/vos/CounterVO.dart';
import 'package:framework/framework.dart';

class CounterProxy extends Proxy {
  static const String NAME = "CounterProxy";

  CounterProxy() : super( NAME ) {
	  print(">\t CounterProxy -> instance created");
  }

  @override
  void onRegister() {
	  print(">\t CounterProxy -> onRegister");
  }

  @override
  void onRemove() {

  }

  @override
  void setData( Object value ) {
  	super.setData( value );
	  _notifyCounterUpdated();
  }

  void _notifyCounterUpdated() {
	  sendNotification( CounterNotification.COUNTER_VALUE_UPDATED, this.getData() );
  }


}