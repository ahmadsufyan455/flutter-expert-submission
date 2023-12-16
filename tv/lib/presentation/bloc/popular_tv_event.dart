part of 'popular_tv_bloc.dart';

@immutable
sealed class PopularTvEvent {
  const PopularTvEvent();
}

final class LoadPopularTv extends PopularTvEvent {}
