import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  final fController = TextEditingController();
  NativeViewController nController;

  @override
  void initState() {
    fController.addListener(() {
      nController.setText(fController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextField(),
          Expanded(
            child: Theme.of(context).platform == TargetPlatform.iOS
                ? UiKitView(
                    viewType: "textView",
                  )
                : AndroidView(
                    viewType: "textView",
                    creationParams: "Hello from flutter",
                    creationParamsCodec: StandardMessageCodec(),
                    onPlatformViewCreated: (id) {
                      nController = NativeViewController(id);
                    },
                  ),
          )
        ],
      ),
    );
  }
}

class NativeViewController {
  MethodChannel _channel;

  NativeViewController(int id) {
    _channel = MethodChannel("textView_$id");
  }

  Future<void> setText(String text) => _channel.invokeMethod("ssetText", text);
}
