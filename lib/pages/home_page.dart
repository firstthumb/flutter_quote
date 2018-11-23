import 'dart:io';
import 'dart:math';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quote/action/quote_actions.dart';
import 'package:flutter_quote/models/app_state.dart';
import 'package:flutter_quote/widget/quote_widget.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  State<StatefulWidget> createState() => _HomePageState(analytics, observer);
}

class _HomePageState extends State<HomePage> {
  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;

  _HomePageState(this.analytics, this.observer);

  static final MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
    keywords: <String>['flutter', 'quote'],
    contentUrl: 'https://flutter.io',
    birthday: new DateTime.now(),
    childDirected: false,
    designedForFamilies: false,
    gender: MobileAdGender.unknown,
    testDevices: <String>[],
  );

  final Random _random = Random();
  final List _colors = [Colors.white];

  int adsCounter = 3;

  Color _selectedColor = Colors.white;

  @override
  void initState() {
    super.initState();

    analytics.logAppOpen();
    analytics.setUserId(_randomString(16));
    _setCurrentScreen();

    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-4636547026546834~4713552358");
  }

  String _randomString(int length) {
    var rand = new Random();
    var codeUnits = new List.generate(length, (index) {
      return rand.nextInt(33) + 89;
    });

    return new String.fromCharCodes(codeUnits);
  }

  _changeColor() {
    setState(() {
      _selectedColor = _colors[_random.nextInt(1)];
    });
  }

  Future<void> _sendQuoteChangeEvent() async {
    await analytics.logEvent(
      name: 'quote_change_event',
      parameters: <String, dynamic>{
        'key': 'value',
      },
    );
  }

  Future<void> _setCurrentScreen() async {
    await analytics.setCurrentScreen(
      screenName: 'MainScreen',
      screenClassOverride: 'MainScreen',
    );
  }

  _loadAds() {
    adsCounter--;
    if (adsCounter <= 0) {
      adsCounter = 1 + Random().nextInt(4);
      InterstitialAd interstitial = new InterstitialAd(
        adUnitId: Platform.isIOS
            ? "ca-app-pub-4636547026546834/9506304910"
            : "ca-app-pub-4636547026546834/9506304910",
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("InterstitialAd event is $event");
        },
      );
      interstitial.load().then((status) {
        if (status) {
          interstitial.show();
        }
      });
    }
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
              _changeColor();
              _sendQuoteChangeEvent();
              _loadAds();
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
