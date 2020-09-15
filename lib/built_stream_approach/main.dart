import 'package:built_stream/stream_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_built_stream/built_stream_approach/built_stream/fetch_data_stream.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FetchDataBloc _fetchDataBloc;
  bool _onlyNewestCall;
  @override
  void initState() {
    super.initState();
    _fetchDataBloc = FetchDataBloc();
    _onlyNewestCall = false;
  }

  void _toggleOnlyNewestCall() {
    setState(() {
      _onlyNewestCall = !_onlyNewestCall;
      _fetchDataBloc.onlyNewestCall = _onlyNewestCall;
    });
  }

  void _fetchHello() {
    _fetchDataBloc.fetchDataSubject.add(FetchDataParams("Hello"));
  }

  void _fetchHenno() {
    _fetchDataBloc.fetchDataSubject.add(FetchDataParams("Henno"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.grey.withOpacity(0.4),
              child: Column(
                children: [
                  RaisedButton(
                    onPressed: _toggleOnlyNewestCall,
                    child: Text("Toggle only get newest call"),
                  ),
                  Text(_onlyNewestCall ? "On" : "Off"),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: _fetchHello,
                  child: Text("Fetch Hello"),
                ),
                SizedBox(
                  width: 10,
                ),
                RaisedButton(
                  onPressed: _fetchHenno,
                  child: Text("Fetch Henno"),
                ),
              ],
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
              child: StreamBuilder<StreamState>(
                  stream: _fetchDataBloc.fetchDataSubject.outputStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData == false) return SizedBox();
                    String result;
                    if (snapshot.data is FetchDataStart) {
                      result = "Start";
                    } else if (snapshot.data is FetchDataSucceed) {
                      result =
                          (snapshot.data as FetchDataSucceed).results.output;
                    } else if (snapshot.data is FetchDataError) {
                      result = (snapshot.data as FetchDataError).error.output;
                    }
                    return Text(
                      result,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
