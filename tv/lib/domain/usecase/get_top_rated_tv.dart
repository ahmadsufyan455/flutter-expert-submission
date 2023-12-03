import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetTopRatedTv {
  final MovieRepository repository;
  GetTopRatedTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTv();
  }
}
