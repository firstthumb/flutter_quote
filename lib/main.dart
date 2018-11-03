import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quote/loading_screen.dart';
import 'package:flutter_quote/middleware/middleware.dart';
import 'package:flutter_quote/pages/home_page.dart';
import 'package:flutter_quote/store/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final store = createStore();

  @override
  Widget build(BuildContext context) {
    return PersistorGate(
      persistor: persistor,
      loading: LoadingScreen(),
      builder: (context) => StoreProvider(
            store: store,
            child: MaterialApp(
              home: HomePage(),
            ),
          ),
    );
  }
}
