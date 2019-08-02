import 'package:flutter/material.dart';

class PreferencesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Preferences"),
        textTheme: TextTheme(
            title: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
        )),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
    );
  }
}
