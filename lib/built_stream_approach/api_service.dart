import 'package:flutter_demo_built_stream/built_stream_approach/built_stream/fetch_data_stream.dart';

class ApiService {
  Future<FetchDataResults> fetchData(FetchDataParams params) async {
    await Future.delayed(Duration(seconds: 1));
    return FetchDataResults(params.input + " World");
  }
}
