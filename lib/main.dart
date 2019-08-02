import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'Mapping.dart';
import 'Authentication.dart';
import 'package:kruuz_client/Models/KruuzState.dart';
import 'package:kruuz_client/Reducers/KruuzReducers.dart';

void main() {
  runApp(new KruuzApp());
}

class KruuzApp extends StatelessWidget {
//  final store = new Store<KruuzState>(
//    KruuzReducer,
//    initialState: new KruuzState(),
//    middleware: [],
//  );
  @override
  Widget build(BuildContext context) {
//    return new StoreProvider(
//      store: store,
    child:
    return new MaterialApp(
      title: "Kruuz",
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MappingPage(
        auth: Auth(),
      ),
    );
//    );
  }
}
