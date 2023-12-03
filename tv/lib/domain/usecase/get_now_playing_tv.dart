import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetNowPlayingTv {
  final MovieRepository repository;
  GetNowPlayingTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNowPlayingTv();
  }
}
