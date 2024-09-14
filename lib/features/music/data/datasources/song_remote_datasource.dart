import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mind_care/features/music/data/models/song_model.dart';

abstract class SongRemoteDatasource {
  Future<List<SongModel>> getAllSongs();
}

class SongRemoteDatasourceImple implements SongRemoteDatasource {
  SongRemoteDatasourceImple({required this.client});
  final http.Client client;

  @override
  Future<List<SongModel>> getAllSongs() async {
    final response =
        await client.get(Uri.parse('http://localhost:6000/songs/all'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((song) => SongModel.fromJson(song)).toList();
    } else {
      throw Exception("Failed to load songs");
    }
  }
}
