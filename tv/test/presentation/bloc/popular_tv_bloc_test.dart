import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import 'package:bloc_test/bloc_test.dart';

import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late PopularTvBloc popularTvBloc;
  late MockGetPopularTv mockGetPopularTv;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    popularTvBloc = PopularTvBloc(mockGetPopularTv);
  });

  test('initial should be empty', () {
    expect(popularTvBloc.state, PopularTvEmpty());
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

  blocTest<PopularTvBloc, PopularTvState>(
      'emits [Loading, Success] when data is gotten successfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => right(tTvList));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(LoadPopularTv()),
      expect: () => [PopularTvLoading(), PopularTvSuccess(tTvList)],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      });

  blocTest<PopularTvBloc, PopularTvState>(
      'Should emit [Loading, Error] when get popular tv is unsuccessful',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer(
            (_) async => left(const ServerFailure('Server Failure')));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(LoadPopularTv()),
      expect: () => [
            PopularTvLoading(),
            const PopularTvError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      });
}
