import 'dart:async';

import 'package:counter_recorder/src/model/ApplicationProxy.dart';
import 'package:counter_recorder/src/model/CounterProxy.dart';
import 'package:counter_recorder/src/model/DatabaseProxy.dart';
import 'package:counter_recorder/src/model/HistoryProxy.dart';
import 'package:counter_recorder/src/model/vos/CounterVO.dart';
import 'package:counter_recorder/src/model/vos/HistoryVO.dart';
import 'package:framework/framework.dart';

class PrepareCompleteCommand extends AsyncCommand
{
	@override
	Future execute(INotification note) async {
		print("> StartupCommand -> PrepareCompleteCommand > execute");

		final DatabaseProxy databaseProxy = facade.retrieveProxy( DatabaseProxy.NAME );
		final ApplicationProxy applicationProxy = facade.retrieveProxy( ApplicationProxy.NAME );
		final CounterProxy counterProxy = facade.retrieveProxy( CounterProxy.NAME );
		final HistoryProxy historyProxy = facade.retrieveProxy( HistoryProxy.NAME );

		CounterVO valueVO = await RetrieveCounterValueFromDatabase(databaseProxy);
		List<HistoryVO> history = await RetrieveHistoryFromDatabase(databaseProxy);

		counterProxy.setData( valueVO );
		historyProxy.setData( history );

		print("> StartupCommand -> PrepareCompleteCommand > valueVO.value = ${valueVO.value}");
		print("> StartupCommand -> PrepareCompleteCommand > history = $history");

		commandComplete();
	}

	Future<CounterVO> RetrieveCounterValueFromDatabase(DatabaseProxy databaseProxy) async {
		CounterVO result;
		List<Map> rawValues = await databaseProxy.retrieveVO( CounterVO );
		if(rawValues.length == 0) {
			result = CounterVO();
			databaseProxy.insertVO( CounterVO, CounterVO.databaseMapKeyValues( result.value ));
		} else {
			result = CounterVO.fromRawValuesIndex( rawValues, index: 0 );
		}
		return result;
	}

	Future<List<HistoryVO>> RetrieveHistoryFromDatabase( DatabaseProxy databaseProxy ) async {
		List<HistoryVO> result = List<HistoryVO>();
		List<Map> rawValues = await databaseProxy.retrieve( HistoryVO );
		print("> StartupCommand -> PrepareCompleteCommand > RetrieveHistoryFromDatabase : rawValues = $rawValues");
		rawValues.forEach((Map rawValue) => result.add( HistoryVO.fromRawValues( rawValue ) ));
		return result;
	}
}