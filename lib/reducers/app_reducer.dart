import 'package:flutter_quote/action/quote_actions.dart';
import 'package:flutter_quote/models/app_state.dart';
import 'package:redux_persist/redux_persist.dart';

AppState appReducer(AppState state, action) {
  print(action);

  if (action is PersistLoadedAction<AppState>) {
    return action.state ?? state;
  } else if (action is LoadedQuoteAction) {
    return AppState(loading: false, quotes: action.quotes);
  } else if (action is LoadingQuoteAction) {
    return AppState(loading: true);
  } else if (action is LoadFailedQuoteAction) {
    print("Error : ${action.error}");
    return AppState(loading: false);
  }

  return state;
}
