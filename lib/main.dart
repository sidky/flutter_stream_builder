import 'dart:async';

import 'package:flutter/material.dart';

import 'splash.dart';
import 'login.dart';
import 'count.dart';
import 'list.dart';

import 'state.dart' as uiState;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StreamBuilder<uiState.UiState> builder = new StreamBuilder(
      stream: new uiState.StateSubject().screenEvent(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasError) {
          return new Text("Error!");
        } else if (asyncSnapshot.data == null) {
          return new SplashScreen();
        }else {
          switch (asyncSnapshot.data.state) {
            case uiState.State.login: return new LoginScreen();
            case uiState.State.count: return new CountScreen();
            case uiState.State.list: return new NumberListScreen();
            default: return null;
          }
        }
      });
    return new MaterialApp(
      title: 'Stream Builder',
      home: builder);
  }
}