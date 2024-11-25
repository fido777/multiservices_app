import 'package:hive/hive.dart';
import 'package:multiservices_app/model/user.dart';

class FavoritesCrud {
  final String userId;

  FavoritesCrud({required this.userId});

  // Future<void> initUserFavorites(String userId) async {
  //   await Hive.openBox<User>('favorites_$userId');
  // }

  // late Box<User> _favoritesBox;

  // Exponer el box para poderlo escuchar
  Box<User> get box => Hive.box<User>('favorites_$userId');

  // // Inicializar la caja con el ID específico del usuario
  // Future<void> initUserFavorites(String userId) async {
  //   _favoritesBox = await Hive.openBox('favorites_$userId');
  // }

  // Añadir un profesional a los favoritos de este usuario
  void addFavorite(User professional) {
    Hive.box<User>('favorites_$userId').put(professional.id, professional);
  }

  // Eliminar un profesional de los favoritos de este usuario
  void deleteFavorite(String professionalId) {
    Hive.box<User>('favorites_$userId').delete(professionalId);
  }

  // Comprobar si un profesional es favorito de este usuario
  bool isFavorite(String professionalId) {
    return Hive.box<User>('favorites_$userId').containsKey(professionalId);
  }

  // Cargar todos los profesionales favoritos de este usuario
  List<User> loadFavorites() {
    return Hive.box<User>('favorites_$userId').values.cast<User>().toList();
  }
}
