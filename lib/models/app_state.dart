import 'package:flutter_quote/models/quote.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final bool loading;
  final List<Quote> quotes;

  AppState({this.loading = false, this.quotes = const []});

  AppState copyWith({bool loading, List<Quote> quotes}) {
    return new AppState(
        loading: loading ?? this.loading, quotes: quotes ?? this.quotes);
  }

  static AppState fromJson(dynamic json) => AppState(
      quotes:
          (json["quotes"] as List).map((map) => Quote.fromJson(map)).toList());

  dynamic toJson() => {"quotes": quotes};

  @override
  String toString() {
    return '''AppState{
        loading: $loading
        quotes: $quotes
        }''';
  }
}
