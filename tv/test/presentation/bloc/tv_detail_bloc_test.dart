import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tv/tv.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvDetailBloc = TvDetailBloc(mockGetTvDetail);
  });

  test('initial should be empty', () {
    expect(tvDetailBloc.state, TvDetailEmpty());
  });

  const tId = 1;

  const List<Season> seasons = [
    Season(
      airDate: 'airDate',
      episodeCount: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
      voteAverage: 1,
    )
  ];

  const tvDetail = TvDetail(
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    lastAirDate: 'lastAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    episodeRunTime: [1],
    homepage: 'homePage',
    inProduction: true,
    languages: ['en'],
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: ['USA'],
    originalLanguage: 'en',
    popularity: 1,
    seasons: seasons,
    status: 'status',
    tagline: 'tagLine',
    type: 'type',
  );

  blocTest<TvDetailBloc, TvDetailState>(
      'emits [Loading, Success] when data is gotten successfully',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => right(tvDetail));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const LoadTvDetail(tId)),
      expect: () =>
          [TvDetailLoading(), const TvDetailSuccess(result: tvDetail)],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tId));
      });

  blocTest<TvDetailBloc, TvDetailState>(
      'emits [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetTvDetail.execute(tId)).thenAnswer(
            (_) async => left(const ServerFailure('Server failure')));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const LoadTvDetail(tId)),
      expect: () => [TvDetailLoading(), const TvDetailError('Server failure')],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tId));
      });
}
