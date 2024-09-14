import 'package:mind_care/features/music/domain/entities/song.dart';
import 'package:mind_care/features/music/domain/repository/song_repository.dart';

class GetAllSongs {
  GetAllSongs({required this.repository});

  final SongRepository repository;

  Future<List<Song>> call() async {
    return await repository.getAllSongs();
  }
}
