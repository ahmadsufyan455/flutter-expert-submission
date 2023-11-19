import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/search_movie_bloc.dart';

import '../bloc/search_tv_bloc.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search';
  final String pageTitle;
  const SearchPage({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                if (pageTitle == movieTitle) {
                  context.read<SearchMovieBloc>().add(OnQueryChanged(query));
                } else if (pageTitle == tvTitle) {
                  context.read<SearchTvBloc>().add(OnQueryChangedTv(query));
                }
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            pageTitle == movieTitle
                ? BlocBuilder<SearchMovieBloc, SearchMovieState>(
                    builder: (context, state) {
                      if (state is SearchMovieLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SearchMovieSuccess) {
                        final result = state.results;
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final movie = result[index];
                              return MovieCard(movie);
                            },
                            itemCount: result.length,
                          ),
                        );
                      } else if (state is SearchMovieError) {
                        return Expanded(
                          child: Center(
                            child: Text(state.error),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(),
                        );
                      }
                    },
                  )
                : BlocBuilder<SearchTvBloc, SearchTvState>(
                    builder: (context, state) {
                      if (state is SearchTvLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SearchTvSuccess) {
                        final result = state.results;
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final tv = result[index];
                              return TvCard(tv);
                            },
                            itemCount: result.length,
                          ),
                        );
                      } else if (state is SearchTvError) {
                        return Expanded(
                          child: Center(
                            child: Text(state.error),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(),
                        );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
