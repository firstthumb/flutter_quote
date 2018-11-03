
import 'package:flutter_quote/models/quote.dart';
import 'package:flutter_quote/repository/quote_repository.dart';

class QuoteService {
  static final QuoteService _instance = QuoteService._internal();

  static QuoteService get() => _instance;

  QuoteService._internal();

  Future<List<Quote>> getQuotes() {
    return QuoteRepository.get().getQuotes();
  }
}