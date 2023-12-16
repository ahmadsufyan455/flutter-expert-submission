part of 'tv_recommendation_bloc.dart';

@immutable
sealed class TvRecommendationState extends Equatable {
  const TvRecommendationState();

  @override
  List<Object> get props => [];
}

final class TvRecommendationEmpty extends TvRecommendationState {}

final class TvRecommendationLoading extends TvRecommendationState {}

final class TvRecommendationsSuccess extends TvRecommendationState {
  final List<Tv> recommendations;
  const TvRecommendationsSuccess(this.recommendations);

  @override
  List<Object> get props => [recommendations];
}

final class TvRecommendationError extends TvRecommendationState {
  final String message;
  const TvRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}
