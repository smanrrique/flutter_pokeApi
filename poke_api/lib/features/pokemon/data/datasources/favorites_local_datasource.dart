import 'package:poke_api/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FavoritesLocalDataSource {
  Future<Set<String>> getFavoriteUrls();
  Future<void> setFavorite(String url, bool isFavorite);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  static const _key = 'favorite_pokemon_urls';

  final SharedPreferences prefs;

  FavoritesLocalDataSourceImpl({required this.prefs});

  @override
  Future<Set<String>> getFavoriteUrls() async {
    try {
      return prefs.getStringList(_key)?.toSet() ?? <String>{};
    } catch (_) {
      throw const CacheException('Could not read favorites');
    }
  }

  @override
  Future<void> setFavorite(String url, bool isFavorite) async {
    try {
      final current = prefs.getStringList(_key)?.toSet() ?? <String>{};
      if (isFavorite) {
        current.add(url);
      } else {
        current.remove(url);
      }
      await prefs.setStringList(_key, current.toList());
    } catch (_) {
      throw const CacheException('Could not write favorites');
    }
  }
}
