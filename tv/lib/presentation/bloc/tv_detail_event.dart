part of 'tv_detail_bloc.dart';

@immutable
sealed class TvDetailEvent {
  const TvDetailEvent();
}

final class LoadTvDetail extends TvDetailEvent {
  final int id;
  const LoadTvDetail(this.id);
}
