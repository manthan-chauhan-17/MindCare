import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_care/features/music/data/datasources/song_remote_datasource.dart';
import 'package:mind_care/features/music/data/repository/song_repository_impl.dart';
import 'package:mind_care/features/music/domain/usecases/get_all_songs.dart';
import 'package:mind_care/features/music/presentation/bloc/song_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mind_care/features/music/presentation/bloc/song_event.dart';
import 'package:mind_care/screens/bottomNavBar/bloc/navigation_bloc.dart';
import 'package:mind_care/screens/homePage/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NavigationBloc(),
        ),
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
