import 'package:hive/hive.dart';
import 'package:multiservices_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class Boxes {
  static Box<User> get localJobsBox => Hive.box<User>('favorites');

  void addToFavorites(User user) {
    final favoritesBox = Hive.box<User>('favorites');
    favoritesBox.put(user.uuid, user); // Save user with uuid as key
  }

  void removeFromFavorites(String uuid) {
    final favoritesBox = Hive.box<User>('favorites');
    favoritesBox.delete(uuid); // Remove user by uuid
  }

  bool isFavorite(String uuid) {
    final favoritesBox = Hive.box<User>('favorites');
    return favoritesBox.containsKey(uuid);
  }
}
