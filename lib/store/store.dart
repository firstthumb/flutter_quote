import 'package:flutter_quote/middleware/middleware.dart';
import 'package:flutter_quote/models/app_state.dart';
import 'package:flutter_quote/reducers/app_reducer.dart';
import 'package:redux/redux.dart';

Store<AppState> createStore() {
  Store<AppState> store = new Store(
    appReducer,
    initialState: new AppState(),
    middleware: createMiddleware(),
  );

  persistor.load(store);

  return store;
}
