part of 'now_playing_tv_bloc.dart';

@immutable
sealed class NowPlayingTvState extends Equatable {
  const NowPlayingTvState();

  @override
  List<Object> get props => [];
}

final class NowPlayingTvEmpty extends NowPlayingTvState {}

final class NowPlayingTvLoading extends NowPlayingTvState {}

final class NowPlayingTvError extends NowPlayingTvState {
  final String message;
  const NowPlayingTvError(this.message);

  @override
  List<Object> get props => [message];
}

final class NowPlayingTvSuccess extends NowPlayingTvState {
  final List<Tv> results;
  const NowPlayingTvSuccess(this.results);

  @override
  List<Object> get props => [results];
}
