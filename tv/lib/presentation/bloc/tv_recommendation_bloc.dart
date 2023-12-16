import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

part 'tv_recommendation_event.dart';
part 'tv_recommendation_state.dart';

class TvRecommendationBloc
    extends Bloc<TvRecommendationEvent, TvRecommendationState> {
  final GetTvRecommendation _getTvRecommendation;
  TvRecommendationBloc(this._getTvRecommendation)
      : super(TvRecommendationEmpty()) {
    on<LoadTvRecommendations>((event, emit) async {
      emit(TvRecommendationLoading());
      final result = await _getTvRecommendation.execute(event.id);
      result.fold(
        (failure) => emit(TvRecommendationError(failure.message)),
        (data) => emit(TvRecommendationsSuccess(data)),
      );
    });
  }
}
