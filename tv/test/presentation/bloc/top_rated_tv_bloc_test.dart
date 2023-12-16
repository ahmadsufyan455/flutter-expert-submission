import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tv/tv.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
  });

  test('initial should be empty', () {
    expect(topRatedTvBloc.state, TopRatedTvEmpty());
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

  blocTest<TopRatedTvBloc, TopRatedTvState>(
      'emits [Loading, Success] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => right(tTvList));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(LoadTopRatedTv()),
      expect: () => [TopRatedTvLoading(), TopRatedTvSuccess(tTvList)],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      });

  blocTest<TopRatedTvBloc, TopRatedTvState>(
      'Should emit [Loading, Error] when get top rated tv is unsuccessful',
      build: () {
        when(mockGetTopRatedTv.execute()).thenAnswer(
            (_) async => left(const ServerFailure('Server Failure')));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(LoadTopRatedTv()),
      expect: () => [
            TopRatedTvLoading(),
            const TopRatedTvError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      });
}
