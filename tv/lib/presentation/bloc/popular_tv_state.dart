part of 'popular_tv_bloc.dart';

@immutable
sealed class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object> get props => [];
}

final class PopularTvEmpty extends PopularTvState {}

final class PopularTvLoading extends PopularTvState {}

final class PopularTvError extends PopularTvState {
  final String message;
  const PopularTvError(this.message);

  @override
  List<Object> get props => [message];
}

final class PopularTvSuccess extends PopularTvState {
  final List<Tv> results;
  const PopularTvSuccess(this.results);

  @override
  List<Object> get props => [results];
}
