import 'package:dartz/dartz.dart';
import '../../utils/failure.dart';
import '../entities/tv.dart';
import '../repositories/movie_repository.dart';

class GetWatchListTv {
  final MovieRepository _repository;

  GetWatchListTv(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchlistTv();
  }
}
