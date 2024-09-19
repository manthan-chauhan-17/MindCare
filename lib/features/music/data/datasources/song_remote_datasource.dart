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
    try {
      // Using emulator's ip address instead of localhost
      final response =
          await client.get(Uri.parse('http://10.0.2.2:6000/songs/all'));
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        print("Response data: $jsonResponse");
        return jsonResponse.map((song) => SongModel.fromJson(song)).toList();
      } else {
        throw Exception("Failed to load songs");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to load songs due to error: $e");
    }
  }
}
