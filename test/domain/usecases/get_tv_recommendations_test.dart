import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendation usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTvRecommendation(mockMovieRepository);
  });

  final tId = 1;
  final tTvList = <Tv>[];

  test('should get list of tv recommendations from the repository', () async {
    // arrange
    when(mockMovieRepository.getTvRecommendations(tId))
        .thenAnswer((_) async => Right(tTvList));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvList));
  });
}
