import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quote/action/quote_actions.dart';
import 'package:flutter_quote/models/app_state.dart';
import 'package:flutter_quote/widget/quote_widget.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Random _random = Random();
  List _colors = [Colors.white];

  Color _selectedColor = Colors.white;

  _changeQuote() {
    setState(() {
      _selectedColor = _colors[_random.nextInt(1)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, VoidCallback>(
        converter: (Store<AppState> store) {
          return () {
            store.dispatch(LoadQuoteAction());
          };
        },
        onInit: (Store<AppState> store) {
          store.dispatch(LoadQuoteAction());
        },
        builder: (BuildContext context, VoidCallback loadQuote) {
          return new GestureDetector(
            onTap: () {
              _changeQuote();
              loadQuote();
            },
            child: Container(
              color: _selectedColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[QuoteWidget()],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
