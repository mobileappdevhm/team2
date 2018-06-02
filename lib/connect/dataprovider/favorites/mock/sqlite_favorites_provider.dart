import 'package:courses_in_english/connect/dataprovider/favorites/favorites_provider.dart';

class MockFavoritesProvider extends FavoritesProvider {
  Set<int> _favorites = new Set();

  @override
  Set<int> toggleFavorite(int id) {
    // if adding the course fails, remove it from set
    if (!_favorites.add(id)) _favorites.remove(id);
    notifyObservers();
    return getFavorites();
  }

  @override
  Set<int> getFavorites() {
    return _favorites;
  }
}
