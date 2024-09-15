import 'package:mind_care/features/music/domain/entities/song.dart';

abstract class SongState {}

class SongInitial extends SongState {}

class SongLoading extends SongState {}

class SongLoaded extends SongState {
  SongLoaded({required this.songs});

  final List<Song> songs;
}

class SongError extends SongState {
  SongError({required this.message});

  final String message;
}
