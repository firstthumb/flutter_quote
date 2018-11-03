import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quote/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class QuoteWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QuoteWidgetState();
}

class _QuoteWidgetState extends State<QuoteWidget> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (Store<AppState> store) {
        return store.state;
      },
      builder: (BuildContext context, AppState appState) {
        if (appState.loading || appState.quotes == null) {
          return Center(
            child: new CircularProgressIndicator(
                backgroundColor: Colors.blueGrey, strokeWidth: 2.0),
          );
        }

        final _quote = appState.quotes.first;

        return Container(
            child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  child: Text(
                    "\u201c",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color(0xFF16B6DF),
                        fontSize: 180.0,
                        fontFamily: "Arial"),
                  ),
                  padding: EdgeInsets.only(left: 0.0, top: 0.0),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: AutoSizeText(
                    _quote.content,
                    textAlign: TextAlign.left,
                    maxLines: 6,
                    style: TextStyle(
                        color: Color(0xFF545454),
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Lora"),
                  ),
                )),
                Padding(
                  child: Text(
                    "\u201d",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: Color(0xFF16B6DF),
                        fontSize: 180.0,
                        fontFamily: "Arial"),
                  ),
                  padding: EdgeInsets.only(top: 50.0),
                ),
              ],
            ),
            Container(
              child: Text(
                _quote.title,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color(0xFF16B6DF),
                    fontSize: 24.0,
                    fontFamily: "Arial"),
              ),
            )
          ],
        ));
      },
    );
  }
}
