import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetPopularTv {
  final MovieRepository repository;
  GetPopularTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getPopularTv();
  }
}
