import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late SearchTvBloc searchTvBloc;
  late MockSearchTv mockSearchTv;

  setUp(() {
    mockSearchTv = MockSearchTv();
    searchTvBloc = SearchTvBloc(mockSearchTv);
  });

  test('initial should be empty', () {
    expect(searchTvBloc.state, SearchTvEmpty());
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
  const tQuery = 'spiderman';

  blocTest<SearchTvBloc, SearchTvState>(
      'emits [Loading, Success] when data is gotten successfully',
      build: () {
        when(mockSearchTv.execute(tQuery))
            .thenAnswer((_) async => right(tTvList));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChangedTv(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [SearchTvLoading(), SearchTvSuccess(tTvList)],
      verify: (bloc) {
        verify(mockSearchTv.execute(tQuery));
      });

  blocTest<SearchTvBloc, SearchTvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchTv.execute(tQuery)).thenAnswer(
            (_) async => left(const ServerFailure('Server Failure')));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChangedTv(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            SearchTvLoading(),
            const SearchTvError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockSearchTv.execute(tQuery));
      });
}
