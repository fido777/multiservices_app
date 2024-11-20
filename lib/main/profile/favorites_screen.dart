import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:multiservices_app/model/user.dart';
import 'package:multiservices_app/utils/assets.dart';

class FavoritesScreen extends StatefulWidget {
  final List<User> favorites;

  const FavoritesScreen({super.key, required this.favorites});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late Box<User> favoritesBox;

  @override
  void initState() {
    super.initState();
    favoritesBox = Hive.box<User>('favorites');
  }

  void _removeFromFavorites(String uuid) {
    favoritesBox.delete(uuid);
    setState(() {}); // Refresh the UI after removing
  }

  @override
  Widget build(BuildContext context) {
    final favorites = favoritesBox.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('No hay favoritos'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final user = favorites[index];
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
                          backgroundImage: user.imageUrl != null
                              ? NetworkImage(user.imageUrl!)
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
                                user.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user.city,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user.email,
                                style: TextStyle(
                                  color: Colors.blue.shade400,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user.phone ?? 'No disponible',
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
                            _removeFromFavorites(user.uuid);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
