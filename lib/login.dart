import 'package:flutter/material.dart';
import 'state.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
          child: new RaisedButton(
            onPressed: () {
              emulateLogin();
            },
            child: new Text('Log In'),
          )
      ),
      primary: true,
    );
  }

  emulateLogin() {
    new StateSubject().update(new Count());
  }
}

