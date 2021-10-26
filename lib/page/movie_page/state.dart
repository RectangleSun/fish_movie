import 'package:fish_redux/fish_redux.dart';

class MovieState implements Cloneable<MovieState> {

  @override
  MovieState clone() {
    return MovieState();
  }
}

MovieState initState(Map<String, dynamic> args) {
  return MovieState();
}
