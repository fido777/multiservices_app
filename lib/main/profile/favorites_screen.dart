// favorites_screen.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multiservices_app/model/user.dart';
import 'package:multiservices_app/repository/favorites_crud.dart';
import 'package:multiservices_app/utils/assets.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late final auth.FirebaseAuth _auth;
  late final FavoritesCrud _favoritesCrud;
  late final String _userId;

  @override
  void initState() {
    super.initState();
    _init();
  }


  Future<void> _init() async {
    _auth = auth.FirebaseAuth.instance;
    _userId = _auth.currentUser?.uid ?? '';
    _favoritesCrud = FavoritesCrud(userId: _userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: ValueListenableBuilder(
        valueListenable: _favoritesCrud.box.listenable(),
        builder: (context, Box<User> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('No hay favoritos'));
          }
          final favoriteProfessionals = box.values.toList().cast<User>();
          return ListView.builder(
            itemCount: favoriteProfessionals.length,
            itemBuilder: (context, index) {
              final professional = favoriteProfessionals[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                margin: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // Profile Image
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: professional.imageUrl != null
                            ? NetworkImage(professional.imageUrl!)
                            : AssetImage(Assets.avatarPlaceholder)
                                as ImageProvider,
                      ),
                      const SizedBox(width: 16),

                      // Professional Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              professional.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              professional.city,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              professional.email,
                              style: TextStyle(
                                color: Colors.blue.shade400,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              professional.phone ?? 'No disponible',
                              style: TextStyle(
                                color: Colors.green.shade400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Remove Icon
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _favoritesCrud.deleteFavorite(professional.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
