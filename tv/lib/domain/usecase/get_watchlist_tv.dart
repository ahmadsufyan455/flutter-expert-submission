import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetWatchListTv {
  final MovieRepository _repository;

  GetWatchListTv(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchlistTv();
  }
}
