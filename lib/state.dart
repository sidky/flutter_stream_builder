import 'dart:async';
import 'dart:ui';

import 'package:rxdart/subjects.dart';

enum State {
  login, count, list
}

abstract class UiState {
  State state;

  UiState(this.state);

  @override
  String toString() => "State: $state";
}

class Login extends UiState {
  Login(): super(State.login);
}

class Count extends UiState {
  static const List<Color> colors = const [ 
    const Color.fromARGB(0x1f, 0xff, 0x00, 0x00),
    const Color.fromARGB(0x1f, 0x00, 0xff, 0x00),
    const Color.fromARGB(0x1f, 0x00, 0x00, 0xff),
    const Color.fromARGB(0xff, 0xff, 0x00, 0xff)
  ];

  int _value = 0;
  Color color;

  int get value => _value;
  void set value(newValue) {
    this._value = newValue;
    this.color = colors[newValue % colors.length];
  }

  Count(): super(State.count) {
    color = colors[0];
  }

  Count.withValue(int initialValue): super(State.count) {
    value = initialValue;
  }
}

class NumberList extends UiState {
  List<int> values = [];

  NumberList() : super(State.list);

  NumberList.withValues(List<int> values): super(State.list) {
    this.values = values;
  }

  add(int value) {
    values.add(value);
  }
}

class StateSubject {
  static final StateSubject _instance = new StateSubject._();

  BehaviorSubject<UiState> _subject;

  update(UiState state) => this._subject.add(state);

  factory StateSubject() => StateSubject._instance;

  StateSubject._() {
    this._subject = new BehaviorSubject();
  }
  
  Stream<UiState> filter(State state) {
    return this._subject.stream.expand((uiState) => uiState.state == state ? [uiState] : []).stream;
  }

  Stream<UiState> screenEvent() {
    return this._subject
        .stream
        .scan((_ScannedUiState acc, state, index) {
          bool ignored;
          ignored = (acc != null && acc.state.state == state.state);
          return new _ScannedUiState(state, ignored);
        })
        .expand((_ScannedUiState scanned) {
          if (scanned.equalsToPrev) {
            return [];
          } else {
            return [scanned.state];
          }
        })
        .stream;
  }

  switchToLogin() => update(new Login());
  switchToCount() => update(new Count());
  switchToList() => update(new NumberList());
  increment(int to) => update(new Count.withValue(to));
  updateList(List<int> list) => update(new NumberList.withValues(list));
}

class _ScannedUiState {
  final UiState state;
  final bool equalsToPrev;

  _ScannedUiState(this.state, this.equalsToPrev);
}