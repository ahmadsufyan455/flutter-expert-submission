part of 'search_tv_bloc.dart';

@immutable
sealed class SearchTvState extends Equatable {
  const SearchTvState();

  @override
  List<Object> get props => [];
}

final class SearchTvEmpty extends SearchTvState {}

final class SearchTvLoading extends SearchTvState {}

final class SearchTvError extends SearchTvState {
  final String error;
  const SearchTvError(this.error);

  @override
  List<Object> get props => [error];
}

final class SearchTvSuccess extends SearchTvState {
  final List<Tv> results;
  const SearchTvSuccess(this.results);

  @override
  List<Object> get props => [results];
}
