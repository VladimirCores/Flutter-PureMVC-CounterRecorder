import 'package:counter_recorder/consts/notification/CounterNotification.dart';
import 'package:counter_recorder/consts/notification/HistoryNotification.dart';
import 'package:counter_recorder/consts/types/CounterHistoryAction.dart';
import 'package:counter_recorder/src/model/vos/CounterVO.dart';
import 'package:counter_recorder/src/model/vos/HistoryVO.dart';
import 'package:framework/framework.dart';

class HistoryProxy extends Proxy {
	static const String NAME = "HistoryProxy";

	HistoryProxy() : super( NAME ) {
		print(">\t HistoryProxy -> instance created");
	}

	@override
	void onRegister() {
		print(">\t HistoryProxy -> onRegister");
	}

	@override
	void onRemove() {

	}

	List<List<String>> getHistoryToDisplay() {
		var result = _history.map(( HistoryVO item ) {
			List<String> row = [];
			row.add( item.action == CounterHistoryAction.INCREMENT ? "INCREMENT" : "DECREMENT" );
			row.add( DateTime.fromMillisecondsSinceEpoch( item.time, isUtc: true ).toString() );
			row.add( item.value.toString() );
			return row;
		})
		.toList();
		return result.reversed.toList();
	}

	void addHistoryItem( HistoryVO item ) {
		(getData() as List<HistoryVO>).add( item );
	}

	List<HistoryVO> get _history => getData() as List<HistoryVO>;

	void deleteHistoryItem( HistoryVO item ) {
		_history.remove( item );
		sendNotification( HistoryNotification.HISTORY_UPDATED, getHistoryToDisplay() );
	}

	void deleteHistoryItemsFromList( List<HistoryVO> list ) {
		list.forEach((item) => _history.remove(item));
		sendNotification( HistoryNotification.HISTORY_UPDATED, getHistoryToDisplay() );
	}

	int get itemsInHistory => _history.length;

	HistoryVO getHistoryItemAtReverseIndex( int index ) => _history[ _history.length - 1 - index ];
	HistoryVO getLastHistoryItem() => _history.last;

	List<HistoryVO> getHistoryItemsUntilReverseIndex( int revertToIndex ) {
		int lastIndex = _history.length;
		int startIndex = lastIndex - revertToIndex;
		return _history.getRange(startIndex, lastIndex).toList();
	}
}