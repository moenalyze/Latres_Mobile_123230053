import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tv_show.dart';

class TvService {
  static const String baseUrl = 'https://api.tvmaze.com';

  Future<List<TvShow>> fetchShows() async {
    final response = await http.get(Uri.parse('$baseUrl/shows'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => TvShow.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load shows');
    }
  }

  Future<TvShow> fetchShowDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/shows/$id'));

    if (response.statusCode == 200) {
      return TvShow.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load show details');
    }
  }
}
