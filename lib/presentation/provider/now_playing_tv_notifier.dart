import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';
import 'package:flutter/material.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/tv.dart';

class NowPlayingTvNotifier extends ChangeNotifier {
  final GetNowPlayingTv getNowPlayingTv;

  NowPlayingTvNotifier(this.getNowPlayingTv);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tvShows = [];
  List<Tv> get tvShows => _tvShows;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingTvShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvShowsData) {
        _tvShows = tvShowsData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
