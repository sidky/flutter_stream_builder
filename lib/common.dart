import 'package:flutter/material.dart';
import 'state.dart';

AppBar commonAppBar(String title, void action()) {
  return new AppBar(
    title: new Text(title),
    actions: [
      new IconButton(icon: new Icon(Icons.flip), onPressed: action),
      new IconButton(icon: new Icon(Icons.exit_to_app), onPressed: () {
        new StateSubject().switchToLogin();
      }),
    ],
  );
}

