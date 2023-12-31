import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMovieBloc popularMovieBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieBloc = PopularMovieBloc(mockGetPopularMovies);
  });

  test('initial should be empty', () {
    expect(popularMovieBloc.state, PopularMovieInitial());
  });

  const tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  blocTest<PopularMovieBloc, PopularMovieState>(
      'emits [Loading, Success] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => right(tMovieList));
        return popularMovieBloc;
      },
      act: (bloc) => bloc.add(LoadPopularMovie()),
      expect: () => [PopularMovieLoading(), PopularMovieSuccess(tMovieList)],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      });

  blocTest<PopularMovieBloc, PopularMovieState>(
      'Should emit [Loading, Error] when get popular movie is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (_) async => left(const ServerFailure('Server Failure')));
        return popularMovieBloc;
      },
      act: (bloc) => bloc.add(LoadPopularMovie()),
      expect: () => [
            PopularMovieLoading(),
            const PopularMovieError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      });
}
