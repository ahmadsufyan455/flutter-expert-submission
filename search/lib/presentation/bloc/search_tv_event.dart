part of 'search_tv_bloc.dart';

@immutable
sealed class SearchTvEvent {
  const SearchTvEvent();
}

final class OnQueryChangedTv extends SearchTvEvent {
  final String query;
  const OnQueryChangedTv(this.query);
}
