import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import 'package:bloc_test/bloc_test.dart';

import 'now_playing_tv_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late NowPlayingTvBloc nowPlayingTvBloc;
  late MockGetNowPlayingTv mockGetNowPlayingTv;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    nowPlayingTvBloc = NowPlayingTvBloc(mockGetNowPlayingTv);
  });

  test('initial should be empty', () {
    expect(nowPlayingTvBloc.state, NowPlayingTvEmpty());
  });

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

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
      'emits [Loading, Success] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => right(tTvList));
        return nowPlayingTvBloc;
      },
      act: (bloc) => bloc.add(LoadNowPlayingTv()),
      expect: () => [NowPlayingTvLoading(), NowPlayingTvSuccess(tTvList)],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      });

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
      'Should emit [Loading, Error] when get now playing tv is unsuccessful',
      build: () {
        when(mockGetNowPlayingTv.execute()).thenAnswer(
            (_) async => left(const ServerFailure('Server Failure')));
        return nowPlayingTvBloc;
      },
      act: (bloc) => bloc.add(LoadNowPlayingTv()),
      expect: () => [
            NowPlayingTvLoading(),
            const NowPlayingTvError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      });
}
