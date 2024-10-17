import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_care/features/meditation/data/datasources/meditation_remote_datasource.dart';
import 'package:mind_care/features/meditation/data/repositories/meditation_repository_impl.dart';
import 'package:mind_care/features/meditation/domain/usecases/get_daily_quote.dart';
import 'package:mind_care/features/meditation/domain/usecases/get_mood_message.dart';
import 'package:mind_care/features/meditation/presentation/bloc/daily_quote/daily_quote_bloc.dart';
import 'package:mind_care/features/meditation/presentation/bloc/daily_quote/daily_quote_event.dart';
import 'package:mind_care/features/meditation/presentation/bloc/mood_message/mood_message_bloc.dart';
import 'package:mind_care/features/music/data/datasources/song_remote_datasource.dart';
import 'package:mind_care/features/music/data/repository/song_repository_impl.dart';
import 'package:mind_care/features/music/domain/usecases/get_all_songs.dart';
import 'package:mind_care/features/music/presentation/bloc/song_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mind_care/features/music/presentation/bloc/song_event.dart';
import 'package:mind_care/screens/bottomNavBar/bloc/navigation_bloc.dart';
import 'package:mind_care/screens/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Navigation Bloc
        BlocProvider(
          create: (_) => NavigationBloc(),
        ),
        // Songs Bloc
        BlocProvider(
          create: (context) => SongBloc(
            getAllSongs: GetAllSongs(
              repository: SongRepositoryImpl(
                songRemoteDatasource: SongRemoteDatasourceImple(
                  client: http.Client(),
                ),
              ),
            ),
          )..add(
              FetchSongs(),
            ),
        ),
        BlocProvider(
          create: (context) => DailyQuoteBloc(
            getDailyQuote: GetDailyQuote(
              repository: MeditationRepositoryImpl(
                remoteDatasource: MeditationRemoteDatasourceImpl(
                  client: http.Client(),
                ),
              ),
            ),
          )..add(FetchDailtyQuotes()),
        ),
        BlocProvider(
          create: (context) => MoodMessageBloc(
            getMoodMessage: GetMoodMessage(
              repository: MeditationRepositoryImpl(
                remoteDatasource: MeditationRemoteDatasourceImpl(
                  client: http.Client(),
                ),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Onboarding(),
      ),
    );
  }
}
