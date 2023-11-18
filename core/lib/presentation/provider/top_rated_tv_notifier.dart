import '../../domain/usecases/get_top_rated_tv.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/state_enum.dart';
import '../../domain/entities/tv.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvNotifier(this.getTopRatedTv);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Tv> _tvShows = [];
  List<Tv> get tvShows => _tvShows;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvShows() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvShowsData) {
        _tvShows = tvShowsData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
