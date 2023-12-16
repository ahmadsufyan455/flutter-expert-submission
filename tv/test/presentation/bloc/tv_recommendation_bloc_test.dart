import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tv/tv.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';

import 'tv_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendation])
void main() {
  late TvRecommendationBloc tvRecommendationBloc;
  late MockGetTvRecommendation mockGetTvRecommendation;

  setUp(() {
    mockGetTvRecommendation = MockGetTvRecommendation();
    tvRecommendationBloc = TvRecommendationBloc(mockGetTvRecommendation);
  });

  test('initial should be empty', () {
    expect(tvRecommendationBloc.state, TvRecommendationEmpty());
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
  const tvId = 1;

  blocTest<TvRecommendationBloc, TvRecommendationState>(
      'emits [Loading, Success] when data is gotten successfully',
      build: () {
        when(mockGetTvRecommendation.execute(tvId))
            .thenAnswer((_) async => right(tTvList));
        return tvRecommendationBloc;
      },
      act: (bloc) => bloc.add(const LoadTvRecommendations(tvId)),
      expect: () =>
          [TvRecommendationLoading(), TvRecommendationsSuccess(tTvList)],
      verify: (bloc) {
        verify(mockGetTvRecommendation.execute(tvId));
      });

  blocTest<TvRecommendationBloc, TvRecommendationState>(
      'Should emit [Loading, Error] when get recommendations tv is unsuccessful',
      build: () {
        when(mockGetTvRecommendation.execute(tvId)).thenAnswer(
            (_) async => left(const ServerFailure('Server Failure')));
        return tvRecommendationBloc;
      },
      act: (bloc) => bloc.add(const LoadTvRecommendations(tvId)),
      expect: () => [
            TvRecommendationLoading(),
            const TvRecommendationError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetTvRecommendation.execute(tvId));
      });
}
