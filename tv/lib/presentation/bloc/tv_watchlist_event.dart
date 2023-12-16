part of 'tv_watchlist_bloc.dart';

@immutable
sealed class TvWatchlistEvent {
  const TvWatchlistEvent();
}

final class AddWatchList extends TvWatchlistEvent {
  final TvDetail tv;
  const AddWatchList(this.tv);
}

final class RemoveFromWatchList extends TvWatchlistEvent {
  final TvDetail tv;
  const RemoveFromWatchList(this.tv);
}

final class LoadWatchListStatus extends TvWatchlistEvent {
  final int id;
  const LoadWatchListStatus(this.id);
}

final class LoadWatchListTv extends TvWatchlistEvent {
  const LoadWatchListTv();
}
