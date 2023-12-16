part of 'tv_watchlist_bloc.dart';

@immutable
sealed class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object> get props => [];
}

final class TvWatchlistInitial extends TvWatchlistState {}

final class SuccessMessage extends TvWatchlistState {
  final String message;
  const SuccessMessage(this.message);

  @override
  List<Object> get props => [message];
}

final class FailedMessage extends TvWatchlistState {
  final String message;
  const FailedMessage(this.message);

  @override
  List<Object> get props => [message];
}

final class WatchListStatusAdded extends TvWatchlistState {
  final bool isAddedToWatchList;
  const WatchListStatusAdded(this.isAddedToWatchList);

  @override
  List<Object> get props => [isAddedToWatchList];
}

final class TvWatchListLoading extends TvWatchlistState {}

final class TvWatchListSuccess extends TvWatchlistState {
  final List<Tv> results;
  const TvWatchListSuccess(this.results);

  @override
  List<Object> get props => [results];
}

final class TvWatchListError extends TvWatchlistState {
  final String message;
  const TvWatchListError(this.message);

  @override
  List<Object> get props => [message];
}
