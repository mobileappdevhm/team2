import 'package:courses_in_english/connect/dataprovider/favorites/favorites_observer.dart';

abstract class FavoritesProvider {
  Set<FavoritesObserver> _observers = new Set();

  /// Return list of courses favored by user.
  Set<int> getFavorites();

  /// Add/Remove course with [id] from favorites and return altered list of favorites.
  Set<int> toggleFavorite(int id);

  bool isFavored(int id) {
    return getFavorites().contains(id);
  }

  bool addObserver(FavoritesObserver observer) => _observers.add(observer);

  bool removeObserver(FavoritesObserver observer) =>
      _observers.remove(observer);

  void notifyObservers() =>
      _observers.forEach((observer) => observer.onFavoriteToggled());
}
