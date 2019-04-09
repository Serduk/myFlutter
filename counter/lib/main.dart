import 'package:flutter/material.dart';

void main() => runApp(CounterApp());

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'title',
      theme: ThemeData(primarySwatch: Colors.red),
      home: CounterScreen('Counter', 0),
    );
  }
}

class CounterScreen extends StatefulWidget {
  final String title;
  final int _initial;

  CounterScreen(this.title, this._initial);

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _counter = widget._initial;
  }

  _incrementCounter() => setState(() {
        _counter++;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
//          elevation: Theme.of(context),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: _incrementCounter),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("PUSH BUTTON MANY TIMES"),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1,
              )
            ],
          ),
        ));
  }
}
