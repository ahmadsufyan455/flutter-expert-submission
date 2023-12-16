// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
import 'package:core/core.dart';
import 'package:movie/movie.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const routeName = '/watchlist-movie';

  const WatchlistMoviesPage({super.key});

  @override
  State<WatchlistMoviesPage> createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware, TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    BlocProvider.of<TvWatchlistBloc>(context).add(const LoadWatchListTv());
    BlocProvider.of<MovieWatchlistBloc>(context)
        .add(const LoadWatchListMovie());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    BlocProvider.of<MovieWatchlistBloc>(context)
        .add(const LoadWatchListMovie());
    BlocProvider.of<TvWatchlistBloc>(context).add(const LoadWatchListTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
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
            child: BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
              builder: (context, state) {
                if (state is MovieWatchListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieWatchListSuccess) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = state.results[index];
                      return MovieCard(movie);
                    },
                    itemCount: state.results.length,
                  );
                } else if (state is MovieWatchListError) {
                  return Center(
                    key: const Key('error_message'),
                    child: Text(state.message),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<TvWatchlistBloc, TvWatchlistState>(
              builder: (context, state) {
                if (state is TvWatchListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvWatchListSuccess) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final tv = state.results[index];
                      return TvCard(tv);
                    },
                    itemCount: state.results.length,
                  );
                } else if (state is TvWatchListError) {
                  return Center(
                    key: const Key('error_message'),
                    child: Text(state.message),
                  );
                }
                return const SizedBox();
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
