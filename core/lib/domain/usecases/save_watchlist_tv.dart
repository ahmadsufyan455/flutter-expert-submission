import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/tv_detail.dart';
import '../repositories/movie_repository.dart';

class SaveWatchListTv {
  final MovieRepository repository;

  SaveWatchListTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchlistTv(tv);
  }
}
