import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTv usecase;
  late MockMovieRepository mockMovieRpository;

  setUp(() {
    mockMovieRpository = MockMovieRepository();
    usecase = GetPopularTv(mockMovieRpository);
  });

  final tTv = <Tv>[];

  group('GetPopularTv Tests', () {
    group('execute', () {
      test(
          'should get list of tv from the repository when execute function is called',
          () async {
        // arrange
        when(mockMovieRpository.getPopularTv())
            .thenAnswer((_) async => Right(tTv));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTv));
      });
    });
  });
}
