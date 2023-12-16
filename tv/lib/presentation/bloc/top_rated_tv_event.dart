part of 'top_rated_tv_bloc.dart';

@immutable
sealed class TopRatedTvEvent {
  const TopRatedTvEvent();
}

final class LoadTopRatedTv extends TopRatedTvEvent {}
