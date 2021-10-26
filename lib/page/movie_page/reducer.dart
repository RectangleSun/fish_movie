import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MovieState> buildReducer() {
  return asReducer(
    <Object, Reducer<MovieState>>{
      MovieAction.action: _onAction,
    },
  );
}

MovieState _onAction(MovieState state, Action action) {
  final MovieState newState = state.clone();
  return newState;
}
