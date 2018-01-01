import 'dart:async';

import 'package:flutter/material.dart';
import 'state.dart' as uiState;
import 'common.dart';

class CountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CountState();
}

class _CountState extends State<CountScreen> {
  int _count;
  Color _color;
  StreamSubscription<uiState.UiState> _subscription;
  uiState.StateSubject _subject;

  _CountState() {
    this._subject = new uiState.StateSubject();
    _subscription = this._subject.filter(uiState.State.count).listen((event) {
      uiState.Count count = event;
      setState(() {
        _color = count.color;
        _count = count.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: commonAppBar("Count", () {
          if (this._subject != null) {
            this._subject.switchToList();
          }
        }),
        body: new Center(child: new Text("${this._count}",
          style: new TextStyle(color: new Color.fromARGB(0xff, 0xff, 0xff, 0xff), fontSize: 150.0),),),
        backgroundColor: this._color,
        floatingActionButton: new FloatingActionButton(
          onPressed: () => this._subject.increment(this._count + 1),
          child: new Icon(Icons.add),));
  }

  @override
  void dispose() {
    super.dispose();
    if (_subscription != null) {
      _subscription.cancel();
    }
  }
}
