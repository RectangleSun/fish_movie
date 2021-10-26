import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MovieAction { action }

class MovieActionCreator {
  static Action onAction() {
    return const Action(MovieAction.action);
  }
}
