import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
  });

  test('initial should be empty', () {
    expect(movieDetailBloc.state, MovieDetailInitial());
  });

  const movieId = 1;

  const movieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [Loading, Success] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(movieId))
            .thenAnswer((_) async => right(movieDetail));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const LoadMovieDetail(movieId)),
      expect: () =>
          [MovieDetailLoading(), const MovieDetailSuccess(movieDetail)],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(movieId));
      });

  blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetMovieDetail.execute(movieId)).thenAnswer(
            (_) async => left(const ServerFailure('Server failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const LoadMovieDetail(movieId)),
      expect: () =>
          [MovieDetailLoading(), const MovieDetailError('Server failure')],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(movieId));
      });
}
