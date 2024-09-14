import 'package:mind_care/features/music/data/datasources/song_remote_datasource.dart';
import 'package:mind_care/features/music/domain/entities/song.dart';
import 'package:mind_care/features/music/domain/repository/song_repository.dart';

class SongRepositoryImpl implements SongRepository {
  final SongRemoteDatasource songRemoteDatasource;

  SongRepositoryImpl({required this.songRemoteDatasource});
  @override
  Future<List<Song>> getAllSongs() async {
    final songModel = await songRemoteDatasource.getAllSongs();
    return songModel;
  }
}
