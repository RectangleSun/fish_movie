import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum home_pageAction { action }

class HomeActionCreator {
  static Action onAction() {
    return const Action(home_pageAction.action);
  }
}
