import 'dart:async';

import 'package:courses_in_english/connect/dataprovider/favorites/favorites_provider.dart';

class MockFavoritesProvider extends FavoritesProvider {
  Set<int> _favorites = new Set();

  @override
  Future<Set<int>> toggleFavorite(int id) async {
    // if adding the course fails, remove it from set
    if (!_favorites.add(id)) _favorites.remove(id);
    return getFavorites();
  }

  @override
  Future<Set<int>> getFavorites() async {
    return new Future(() => _favorites);
  }
}
