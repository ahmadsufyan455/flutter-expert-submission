part of 'tv_detail_bloc.dart';

@immutable
sealed class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

final class TvDetailEmpty extends TvDetailState {}

final class TvDetailLoading extends TvDetailState {}

final class TvDetailError extends TvDetailState {
  final String message;
  const TvDetailError(this.message);

  @override
  List<Object> get props => [message];
}

final class TvDetailSuccess extends TvDetailState {
  final TvDetail result;

  const TvDetailSuccess({required this.result});

  @override
  List<Object> get props => [result];
}
