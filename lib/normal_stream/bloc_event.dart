import 'package:flutter_demo_built_stream/normal_stream/event.dart';
import 'package:flutter_demo_built_stream/normal_stream/api_service.dart';
import 'package:rxdart/subjects.dart';

class BlocEvent {
  BehaviorSubject<Event> _event;
  bool _onlyNewestCall;

  /// this variable help keep the order number of the call
  /// ie: 1st fetch, 2nd fetch
  int _callOrder;

  BlocEvent() {
    _event = BehaviorSubject();
    _callOrder = 0;
    _onlyNewestCall = false;
  }
  get eventStream => _event.stream;
  set onlyNewestCall(bool onlyNewestCall) => _onlyNewestCall = onlyNewestCall;

  fetchData(input) async {
    _callOrder++;
    int callOrder = _callOrder;
    try {
      ApiService apiService = ApiService();
      _event.value = EventStart();
      String result = await apiService.fetchData(input);

      /// if _onlyNewestCall value is true and the value of the current _callOrder
      ///  is different than the local callOrder variable in this function
      /// fetchData will be stop to prevent add new  event to stream
      if (_onlyNewestCall && callOrder != _callOrder) return;

      if (result != "Hello World") throw "Not Hello World";
      _event.value = EventSuccess(result);
    } catch (e) {
      _event.value = EventFailure(e);
    }
  }

  dispose() {
    _event.close();
  }
}
