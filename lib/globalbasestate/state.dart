import 'dart:ui';
import 'package:fish_demo/models/app_user.dart';
import 'package:fish_redux/fish_redux.dart';


abstract class GlobalBaseState {
  Color get themeColor;
  set themeColor(Color color);

  Locale get locale;
  set locale(Locale locale);

  AppUser get user;
  set user(AppUser u);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {
  @override
  Color themeColor;
  @override
  Locale locale;

  @override
  AppUser user;

  @override
  GlobalState clone() {
    return GlobalState()
      ..themeColor = themeColor
      ..locale = locale
      ..user = user;
  }
}
