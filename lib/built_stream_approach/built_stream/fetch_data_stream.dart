import 'dart:async';
import 'package:built_stream/stream_annotations.dart';
import 'package:built_stream/stream_types.dart';
import 'package:customized_streams/customized_streams.dart';
import 'package:flutter_demo_built_stream/built_stream_approach/api_service.dart';


part 'fetch_data_stream.g.dart';

@SingleStream(ApiService, 'fetchData')
@StreamParam('String', 'input')
@StreamResult('String', 'output')
class FetchDataStream extends _FetchDataStreamOrigin {
  @override
  String get errorMessage => 'Cannot fetch data';
}
