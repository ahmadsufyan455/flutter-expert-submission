import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  final GetNowPlayingTv _getNowPlayingTv;
  NowPlayingTvBloc(this._getNowPlayingTv) : super(NowPlayingTvEmpty()) {
    on<LoadNowPlayingTv>((event, emit) async {
      emit(NowPlayingTvLoading());
      final result = await _getNowPlayingTv.execute();
      result.fold(
        (failure) => emit(NowPlayingTvError(failure.message)),
        (data) => emit(NowPlayingTvSuccess(data)),
      );
    });
  }
}
