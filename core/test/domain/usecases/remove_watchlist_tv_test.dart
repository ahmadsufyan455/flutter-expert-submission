import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/remove_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchListTv usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = RemoveWatchListTv(mockMovieRepository);
  });

  test('should remove watchlist tv from repository', () async {
    // arrange
    when(mockMovieRepository.removeWatchlistTv(testTvDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockMovieRepository.removeWatchlistTv(testTvDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
