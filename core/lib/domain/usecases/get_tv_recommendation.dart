import 'package:dartz/dartz.dart';
import '../../utils/failure.dart';
import '../entities/tv.dart';
import '../repositories/movie_repository.dart';

class GetTvRecommendation {
  final MovieRepository repository;

  GetTvRecommendation(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
