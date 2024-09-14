import 'package:mind_care/features/music/domain/entities/song.dart';

abstract class SongRepository {
  Future<List<Song>> getAllSongs();
}
