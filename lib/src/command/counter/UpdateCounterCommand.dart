import 'package:framework/framework.dart';
import 'package:puremvc_counter_recorder_sample/src/model/CounterProxy.dart';
import 'package:puremvc_counter_recorder_sample/src/model/DatabaseProxy.dart';
import 'package:puremvc_counter_recorder_sample/src/model/vos/CounterVO.dart';

class UpdateCounterCommand extends SimpleCommand {
  @override
  void execute(INotification note) async {
    print("> UpdateCounterCommand > note: ${note.getBody()}");
    int value = note.getBody();

    final databaseProxy = facade.retrieveProxy(DatabaseProxy.NAME) as DatabaseProxy;
    final counterProxy = facade.retrieveProxy(CounterProxy.NAME) as CounterProxy;

    final CounterVO counterVO = counterProxy.getData();
    counterVO.value = value;

    final params = CounterVO.databaseMapKeyValues(counterVO.value);

    await databaseProxy.updateVO(
      CounterVO,
      params: params,
      id: counterVO.id,
    );

    counterProxy.setData(counterVO);
  }
}
