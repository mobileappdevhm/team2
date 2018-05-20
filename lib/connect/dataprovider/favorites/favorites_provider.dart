import 'dart:async';

abstract class FavoritesProvider {
  /// Return list of courses favored by user.
  Future<Set<int>> getFavorites();

  /// Add/Remove course with [id] from favorites and return altered list of favorites.
  Future<Set<int>> toggleFavorite(int id);

  Future<bool> isFavored(int id) {
    return getFavorites().then((favorites) => favorites.contains(id));
  }
}
