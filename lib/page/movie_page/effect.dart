import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<MovieState> buildEffect() {
  return combineEffects(<Object, Effect<MovieState>>{
    MovieAction.action: _onAction,
  });
}

void _onAction(Action action, Context<MovieState> ctx) {
}
