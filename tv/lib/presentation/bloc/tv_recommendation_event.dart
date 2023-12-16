part of 'tv_recommendation_bloc.dart';

@immutable
sealed class TvRecommendationEvent {
  const TvRecommendationEvent();
}

final class LoadTvRecommendations extends TvRecommendationEvent {
  final int id;
  const LoadTvRecommendations(this.id);
}
