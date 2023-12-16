import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import 'package:bloc_test/bloc_test.dart';

import 'tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  RemoveWatchListTv,
  SaveWatchListTv,
  GetWatchListTvStatus,
  GetWatchListTv,
])
void main() {
  late TvWatchlistBloc tvWatchlistBloc;
  late MockRemoveWatchListTv mockRemoveWatchListTv;
  late MockSaveWatchListTv mockSaveWatchListTv;
  late MockGetWatchListTvStatus mockGetWatchListTvStatus;
  late MockGetWatchListTv mockGetWatchListTv;

  setUp(() {
    mockRemoveWatchListTv = MockRemoveWatchListTv();
    mockSaveWatchListTv = MockSaveWatchListTv();
    mockGetWatchListTvStatus = MockGetWatchListTvStatus();
    mockGetWatchListTv = MockGetWatchListTv();
    tvWatchlistBloc = TvWatchlistBloc(
      saveWatchListTv: mockSaveWatchListTv,
      removeWatchListTv: mockRemoveWatchListTv,
      getWatchListTvStatus: mockGetWatchListTvStatus,
      getWatchListTv: mockGetWatchListTv,
    );
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

  const tTv = Tv(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalName: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    name: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
    originCountry: ['en'],
    originalLanguage: 'en',
  );

  final tTvList = <Tv>[tTv];

  group('Watchlist', () {
    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'emits [StatusAdded] when watchlist status gotten successfully',
      build: () {
        when(mockGetWatchListTvStatus.execute(tId))
            .thenAnswer((_) async => true);
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchListStatus(tId)),
      expect: () => [const WatchListStatusAdded(true)],
      verify: (bloc) => mockGetWatchListTvStatus.execute(tId),
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'emits [SuccessMessage] when save watchlist function called',
      build: () {
        when(mockSaveWatchListTv.execute(tvDetail))
            .thenAnswer((_) async => right('Added to Watchlist'));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(const AddWatchList(tvDetail)),
      expect: () => [const SuccessMessage('Added to Watchlist')],
      verify: (bloc) => mockSaveWatchListTv.execute(tvDetail),
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'emits [SuccessMessage] when remove watchlist function called',
      build: () {
        when(mockRemoveWatchListTv.execute(tvDetail))
            .thenAnswer((_) async => right('Removed from Watchlist'));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(const RemoveFromWatchList(tvDetail)),
      expect: () => [const SuccessMessage('Removed from Watchlist')],
      verify: (bloc) => mockRemoveWatchListTv.execute(tvDetail),
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'should update watchlist status failed to remove',
      build: () {
        when(mockGetWatchListTvStatus.execute(tId))
            .thenAnswer((_) async => false);
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchListStatus(tId)),
      expect: () => [const WatchListStatusAdded(false)],
      verify: (bloc) => mockGetWatchListTvStatus.execute(tId),
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'emits [FailedMessage] when save watchlist failed',
      build: () {
        when(mockSaveWatchListTv.execute(tvDetail)).thenAnswer(
            (_) async => left(const DatabaseFailure('Database failure')));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(const AddWatchList(tvDetail)),
      expect: () => [const FailedMessage('Database failure')],
      verify: (bloc) => mockSaveWatchListTv.execute(tvDetail),
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'emits [FailedMessage] when remove watchlist failed',
      build: () {
        when(mockRemoveWatchListTv.execute(tvDetail)).thenAnswer(
            (_) async => left(const DatabaseFailure('Database failure')));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(const RemoveFromWatchList(tvDetail)),
      expect: () => [const FailedMessage('Database failure')],
      verify: (bloc) => mockRemoveWatchListTv.execute(tvDetail),
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'emits [Loading, Success] when data gotten successfully',
      build: () {
        when(mockGetWatchListTv.execute())
            .thenAnswer((_) async => right(tTvList));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchListTv()),
      expect: () => [TvWatchListLoading(), TvWatchListSuccess(tTvList)],
      verify: (bloc) => mockGetWatchListTv.execute(),
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'emits [Loading, Error] when data unsuccessfully load',
      build: () {
        when(mockGetWatchListTv.execute()).thenAnswer(
            (_) async => left(const DatabaseFailure('Database failure')));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchListTv()),
      expect: () =>
          [TvWatchListLoading(), const TvWatchListError('Database failure')],
      verify: (bloc) => mockGetWatchListTv.execute(),
    );
  });
}
