import 'dart:async';

import 'package:flutter_stream_builder/state.dart' as uiState;
import 'package:flutter/material.dart';
import 'common.dart';

class NumberListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _NumberListState();
}

class _NumberListState extends State<NumberListScreen> {
  List<int> _numbers = [];
  StreamSubscription<uiState.UiState> _subscription;
  uiState.StateSubject _subject;

  _NumberListState() {
    _subject = new uiState.StateSubject();
    _subscription = _subject.filter(uiState.State.list).listen((event) {
      uiState.NumberList list = event;
      setState(() {
        _numbers = list.values;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: commonAppBar("List", () => this._subject.switchToCount()),
      body: new ListView.builder(
          itemCount: this._numbers.length,
          itemBuilder: (context, index) {
            return new ListTile(title: new Text("${this._numbers[index]}"));
          }),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => this._subject.updateList(new List.from(this._numbers)..add(this._numbers.length)),
        child: new Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    if (_subscription != null) {
      _subscription.cancel();
    }
  }


}

