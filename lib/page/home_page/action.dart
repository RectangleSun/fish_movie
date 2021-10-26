import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum HomePageAction { action,initShowMovies,initComingSoon,initBeast }

class HomeActionCreator {
  static Action onAction() {
    return const Action(HomePageAction.action);
  }
}
