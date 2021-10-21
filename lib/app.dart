import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:fish_demo/routes/routes.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:fish_redux/fish_redux.dart';
import 'actions/app_config.dart';
import 'actions/api/tmdb_api.dart';
import 'actions/user_info_operate.dart';
import 'package:permission_handler/permission_handler.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  final AbstractRoutes routes = Routes.routes;
  final ThemeData _lightTheme =
      ThemeData.light().copyWith(accentColor: Colors.transparent);

  final FirebaseAnalytics analytics = FirebaseAnalytics();

  Future _init() async {
    if (Platform.isAndroid)
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);


    await AppConfig.instance.init(context);

    await TMDBApi.instance.init();

    await UserInfoOperate.whenAppStart();
  }

  @override
  void initState() {


    _init();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie',
      debugShowCheckedModeBanner: false,
      theme: _lightTheme,

      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      home: routes.buildPage('startpage', null),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<Object>(builder: (BuildContext context) {
          return routes.buildPage(settings.name, settings.arguments);
        });
      },
    );
  }
}
