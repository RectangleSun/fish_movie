import 'dart:ui';

import 'package:fish_demo/models/app_user.dart';
import 'package:fish_demo/models/user_premium_model.dart';
import 'package:fish_redux/fish_redux.dart';


enum GlobalAction { changeThemeColor, changeLocale, setUser, setUserPremium }

class GlobalActionCreator {
  static Action onchangeThemeColor() {
    return const Action(GlobalAction.changeThemeColor);
  }


  static Action setUser(AppUser user) {
    return Action(GlobalAction.setUser, payload: user);
  }

  static Action setUserPremium(UserPremiumData premiumData) {
    return Action(GlobalAction.setUserPremium, payload: premiumData);
  }
}
