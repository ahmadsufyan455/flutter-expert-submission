import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:search/domain/usecase/search_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late SearchTv usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchTv(mockMovieRepository);
  });

  final tTvList = <Tv>[];
  const tQuery = 'Spiderman';

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockMovieRepository.searchTv(tQuery))
        .thenAnswer((_) async => Right(tTvList));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvList));
  });
}
