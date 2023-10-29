import 'package:ditonton/domain/repositories/movie_repository.dart';

class GetWatchListTvStatus {
  final MovieRepository repository;

  GetWatchListTvStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTv(id);
  }
}
