import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class RemoveWatchListTv {
  final MovieRepository repository;

  RemoveWatchListTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeWatchlistTv(tv);
  }
}
