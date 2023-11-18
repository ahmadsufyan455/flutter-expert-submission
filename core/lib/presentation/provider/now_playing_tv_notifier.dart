import '../../domain/usecases/get_now_playing_tv.dart';
import 'package:flutter/material.dart';

import '../../utils/state_enum.dart';
import '../../domain/entities/tv.dart';

class NowPlayingTvNotifier extends ChangeNotifier {
  final GetNowPlayingTv getNowPlayingTv;

  NowPlayingTvNotifier(this.getNowPlayingTv);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Tv> _tvShows = [];
  List<Tv> get tvShows => _tvShows;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingTvShows() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingTv.execute();

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
