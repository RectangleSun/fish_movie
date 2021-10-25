import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<HomePageState> buildEffect() {
  return combineEffects(<Object, Effect<HomePageState>>{
    home_pageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<HomePageState> ctx) {
}
