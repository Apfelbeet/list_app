import 'package:flutter/material.dart';
import 'package:list_app/DefaultBody.dart';
import 'package:list_app/blueprints.dart';
import 'package:list_app/data.dart';
import 'package:provider/provider.dart';

import 'storage.dart';

void main() => runApp(MyApp());

///  Setup basic materialapp
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        builder: (_) => Data(),
        child: MaterialApp(
          title: 'List Demo',

          ///Theme (the very important dark theme is yet missing :( )
          theme: ThemeData(
              primarySwatch: Colors.blue,
              bottomSheetTheme:
                  BottomSheetThemeData(backgroundColor: Colors.transparent)),

          ///Call main part of the app
          home: Main(),
        ));
  }
}

/// setup Scaffold and AppBar
class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Prototype"),
        actions: <Widget>[
          ///open storage-file
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: () {
              _tempShowStorage(context);
            },
          )
        ],
      ),
      body: DefaultBody(),
    );
  }
}

/// temporary function to display the underlying storage-file in a bottomsheet
/// this function only exists for testing and debugging
void _tempShowStorage(BuildContext context) {
  Storage.read().then((value) => showModalBottomSheet(
      context: context,
      builder: (context) {
        return DefaultModalBottomSheet(
          child: Text(value),
        );
      }));
}
