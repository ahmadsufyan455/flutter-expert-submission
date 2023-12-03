import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetTvRecommendation {
  final MovieRepository repository;

  GetTvRecommendation(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
