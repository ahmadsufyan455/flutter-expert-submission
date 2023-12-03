import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tv/tv.dart';

import 'now_playing_tv_page_test.mocks.dart';

@GenerateMocks([NowPlayingTvNotifier])
void main() {
  late MockNowPlayingTvNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockNowPlayingTvNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<NowPlayingTvNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const NowPlayingTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loaded);
    when(mockNotifier.tvShows).thenReturn(<Tv>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const NowPlayingTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const NowPlayingTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
