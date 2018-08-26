import 'package:counter_recorder/src/model/ApplicationProxy.dart';
import 'package:counter_recorder/src/model/CounterProxy.dart';
import 'package:counter_recorder/src/model/DatabaseProxy.dart';
import 'package:counter_recorder/src/model/HistoryProxy.dart';
import 'package:counter_recorder/src/model/vos/CounterVO.dart';
import 'package:counter_recorder/src/model/vos/HistoryVO.dart';
import 'package:framework/framework.dart';

class PrepareModelCommand extends AsyncCommand {
  @override
  void execute(INotification note) async {
    print("> StartupCommand -> PrepareModelCommand > note: $note");

    final applicationProxy = ApplicationProxy();
    final databaseProxy = DatabaseProxy();
    final counterProxy = CounterProxy();
    final historyProxy = HistoryProxy();

    facade.registerProxy( applicationProxy );
    facade.registerProxy( databaseProxy );
    facade.registerProxy( counterProxy );
    facade.registerProxy( historyProxy );

    await databaseProxy.init();
    await databaseProxy.createDatabase( CounterVO, CounterVO.databaseObjectDescription() );
//    await databaseProxy.deleteDatabase( HistoryVO );
    await databaseProxy.createDatabase( HistoryVO, HistoryVO.databaseObjectDescription() );

    commandComplete();
  }
}