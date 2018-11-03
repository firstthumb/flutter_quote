import 'package:flutter_quote/models/quote.dart';

class LoadQuoteAction {
  int count;
  String order;
  LoadQuoteAction({this.count = 1, this.order = "rand"});
}

class LoadingQuoteAction {}

class LoadedQuoteAction {
  List<Quote> quotes;
  LoadedQuoteAction({this.quotes});
}

class LoadFailedQuoteAction {
  dynamic error;
  LoadFailedQuoteAction({this.error});
}
