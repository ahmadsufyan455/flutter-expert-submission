import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class SaveWatchListTv {
  final MovieRepository repository;

  SaveWatchListTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchlistTv(tv);
  }
}
