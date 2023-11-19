import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecase/search_tv.dart';

import 'search_movie_bloc.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTv _searchTv;
  SearchTvBloc(this._searchTv) : super(SearchTvEmpty()) {
    on<OnQueryChangedTv>((event, emit) async {
      final query = event.query;
      emit(SearchTvLoading());
      final result = await _searchTv.execute(query);
      result.fold(
        (failure) => emit(SearchTvError(failure.message)),
        (data) => emit(SearchTvSuccess(data)),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
