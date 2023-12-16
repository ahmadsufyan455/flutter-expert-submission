part of 'top_rated_tv_bloc.dart';

@immutable
sealed class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object> get props => [];
}

final class TopRatedTvEmpty extends TopRatedTvState {}

final class TopRatedTvLoading extends TopRatedTvState {}

final class TopRatedTvError extends TopRatedTvState {
  final String message;
  const TopRatedTvError(this.message);

  @override
  List<Object> get props => [message];
}

final class TopRatedTvSuccess extends TopRatedTvState {
  final List<Tv> results;
  const TopRatedTvSuccess(this.results);

  @override
  List<Object> get props => [results];
}
