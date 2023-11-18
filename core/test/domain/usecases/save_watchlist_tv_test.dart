import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchListTv usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SaveWatchListTv(mockMovieRepository);
  });

  test('should save tv to the repository', () async {
    // arrange
    when(mockMovieRepository.saveWatchlistTv(testTvDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockMovieRepository.saveWatchlistTv(testTvDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
