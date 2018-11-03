import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_quote/models/quote.dart';
import 'package:http/http.dart' as http;

class QuoteRepository {
  static final QuoteRepository _instance = QuoteRepository._internal();

  final http.Client client = http.Client();

  static QuoteRepository get() => _instance;

  QuoteRepository._internal();

  Future<List<Quote>> getQuotes() async {
    final response = await client.get(Uri.encodeFull(
        'http://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=1'));

    print("Response : ${response.body}");

    return compute(_parseQuotes, response.body);
  }
}

List<Quote> _parseQuotes(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Quote>((json) => Quote.fromJson(json)).toList();
}
