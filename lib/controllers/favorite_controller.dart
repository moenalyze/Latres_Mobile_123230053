import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/tv_show.dart';

class FavoriteController extends GetxController {
  var favoriteShows = <TvShow>[].obs;
  late Box _favoritesBox;

  @override
  void onInit() {
    super.onInit();
    _favoritesBox = Hive.box('favorites');
    loadFavorites();
  }

  void loadFavorites() {
    final List<dynamic> keys = _favoritesBox.keys.toList();
    final List<TvShow> shows = [];
    
    for (var key in keys) {
      final map = _favoritesBox.get(key);
      if (map != null) {
        shows.add(TvShow.fromHiveMap(map));
      }
    }
    
    favoriteShows.assignAll(shows);
  }

  void toggleFavorite(TvShow show) {
    if (isFavorite(show.id)) {
      _favoritesBox.delete(show.id);
    } else {
      _favoritesBox.put(show.id, show.toJson());
    }
    loadFavorites();
  }

  bool isFavorite(int id) {
    return _favoritesBox.containsKey(id);
  }

  void removeFavorite(int id) {
    _favoritesBox.delete(id);
    loadFavorites();
  }
}
