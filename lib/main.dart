import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'package:flutter_quote/loading_screen.dart';
import 'package:flutter_quote/middleware/middleware.dart';
import 'package:flutter_quote/pages/home_page.dart';
import 'package:flutter_quote/store/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  await FlutterCrashlytics().initialize();

  runZoned<Future<Null>>(() async {
    runApp(MyApp());
  }, onError: (error, stackTrace) async {
    await FlutterCrashlytics()
        .reportCrash(error, stackTrace, forceCrash: false);
  });
}

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
