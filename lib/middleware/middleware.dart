import 'package:flutter_quote/action/quote_actions.dart';
import 'package:flutter_quote/models/app_state.dart';
import 'package:flutter_quote/models/quote.dart';
import 'package:flutter_quote/service/quote_service.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:redux_thunk/redux_thunk.dart';

final persistor = new Persistor<AppState>(
    storage: new FlutterStorage('quote-app'), decoder: AppState.fromJson);

List<Middleware<AppState>> createMiddleware() => <Middleware<AppState>>[
      thunkMiddleware,
      persistor.createMiddleware(),
      new LoggingMiddleware.printer(),
      TypedMiddleware<AppState, LoadQuoteAction>(_fetchQuotes),
    ];

Function _fetchQuotes = _createFetchQuotesMiddleware();

Middleware<AppState> _createFetchQuotesMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    store.dispatch(LoadingQuoteAction());
    try {
      final List<Quote> quotes = await QuoteService.get().getQuotes();
      store.dispatch(LoadedQuoteAction(quotes: quotes));
    } catch (error) {
      store.dispatch(LoadFailedQuoteAction(error: error));
    }
    next(action);
  };
}
