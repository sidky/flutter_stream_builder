import 'package:flutter/material.dart';
import 'state.dart' as uiState;

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    new uiState.StateSubject().switchToLogin();
    return new Scaffold(body: new Center(child: new Text("Splash Screen")),);
  }
}
