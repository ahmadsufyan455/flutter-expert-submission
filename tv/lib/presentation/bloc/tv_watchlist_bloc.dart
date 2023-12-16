import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tv/tv.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final SaveWatchListTv saveWatchListTv;
  final RemoveWatchListTv removeWatchListTv;
  final GetWatchListTvStatus getWatchListTvStatus;
  final GetWatchListTv getWatchListTv;
  TvWatchlistBloc({
    required this.saveWatchListTv,
    required this.removeWatchListTv,
    required this.getWatchListTvStatus,
    required this.getWatchListTv,
  }) : super(TvWatchlistInitial()) {
    on<AddWatchList>((event, emit) async {
      final result = await saveWatchListTv.execute(event.tv);
      result.fold(
        (faiure) => emit(FailedMessage(faiure.message)),
        (successMessage) => emit(SuccessMessage(successMessage)),
      );
    });

    on<RemoveFromWatchList>((event, emit) async {
      final result = await removeWatchListTv.execute(event.tv);
      result.fold(
        (faiure) => emit(FailedMessage(faiure.message)),
        (successMessage) => emit(SuccessMessage(successMessage)),
      );
    });

    on<LoadWatchListStatus>((event, emit) async {
      final result = await getWatchListTvStatus.execute(event.id);
      emit(WatchListStatusAdded(result));
    });

    on<LoadWatchListTv>((event, emit) async {
      emit(TvWatchListLoading());
      final result = await getWatchListTv.execute();
      result.fold(
        (failure) => emit(TvWatchListError(failure.message)),
        (data) => emit(TvWatchListSuccess(data)),
      );
    });
  }
}
