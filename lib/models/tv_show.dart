class TvShow {
  final int id;
  final String name;
  final String? imageUrl;
  final double? rating;
  final List<String> genres;
  final String? summary;

  TvShow({
    required this.id,
    required this.name,
    this.imageUrl,
    this.rating,
    required this.genres,
    this.summary,
  });

  factory TvShow.fromJson(Map<String, dynamic> json) {
    return TvShow(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      imageUrl: json['image'] != null ? json['image']['medium'] : null,
      rating: json['rating'] != null && json['rating']['average'] != null
          ? (json['rating']['average'] as num).toDouble()
          : null,
      genres: json['genres'] != null ? List<String>.from(json['genres']) : [],
      summary: json['summary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'rating': rating,
      'genres': genres,
      'summary': summary,
    };
  }

  factory TvShow.fromHiveMap(Map<dynamic, dynamic> map) {
    return TvShow(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      rating: map['rating'],
      genres: map['genres'] != null ? List<String>.from(map['genres']) : [],
      summary: map['summary'],
    );
  }
}
