part of 'now_playing_tv_bloc.dart';

@immutable
sealed class NowPlayingTvEvent {
  const NowPlayingTvEvent();
}

final class LoadNowPlayingTv extends NowPlayingTvEvent {}
