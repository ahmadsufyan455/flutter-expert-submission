import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/watch_list_tv_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware, TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
    Future.microtask(() =>
        Provider.of<WatchListTvNotifier>(context, listen: false)
            .fetchWatchlistTv());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchListTvNotifier>(context, listen: false).fetchWatchlistTv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.movie), text: 'Movies'),
            Tab(icon: Icon(Icons.tv), text: 'Tv Shows'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<WatchlistMovieNotifier>(
              builder: (context, data, child) {
                if (data.watchlistState == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.watchlistState == RequestState.Loaded) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = data.watchlistMovies[index];
                      return MovieCard(movie);
                    },
                    itemCount: data.watchlistMovies.length,
                  );
                } else {
                  return Center(
                    key: Key('error_message'),
                    child: Text(data.message),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<WatchListTvNotifier>(
              builder: (context, data, child) {
                if (data.watchlistState == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.watchlistState == RequestState.Loaded) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final tv = data.watchlistTv[index];
                      return TvCard(tv);
                    },
                    itemCount: data.watchlistTv.length,
                  );
                } else {
                  return Center(
                    key: Key('error_message'),
                    child: Text(data.message),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
