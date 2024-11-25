// profile_details_screen.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:multiservices_app/model/user.dart';
import 'package:multiservices_app/repository/favorites_crud.dart';
import 'package:multiservices_app/utils/assets.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:hive/hive.dart';

class ProfileDetailsScreen extends StatefulWidget {
  final User user;

  const ProfileDetailsScreen({super.key, required this.user});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  late final auth.FirebaseAuth _auth;
  late final FavoritesCrud _favoritesCrud;
  late final String _userId;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _openFavoritesBox() async {
    if (_userId.isNotEmpty) {
      // Initialize the user's specific Hive box for favorites
      await Hive.openBox<User>('favorites_$_userId');
    }
  }

  Future<void> _init() async {
    _auth = auth.FirebaseAuth.instance;
    _userId = _auth.currentUser?.uid ?? '';
    _favoritesCrud = FavoritesCrud(userId: _userId);
    _openFavoritesBox();
  }

  void toggleFavorite() {
    if (_favoritesCrud.isFavorite(widget.user.id)) {
      _favoritesCrud.deleteFavorite(widget.user.id);
    } else {
      _favoritesCrud.addFavorite(widget.user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user.name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: widget.user.imageUrl != null
                    ? NetworkImage(widget.user.imageUrl!)
                    : AssetImage(Assets.avatarPlaceholder) as ImageProvider,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Name: ${widget.user.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'City: ${widget.user.city}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Email: ${widget.user.email}',
              style: TextStyle(fontSize: 16, color: Colors.blue.shade400),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder(
              valueListenable: _favoritesCrud.box.listenable(),
              builder: (context, Box<User> box, _) {
                final isFavorited = box.containsKey(widget.user.id);
                return ElevatedButton.icon(
                  onPressed: toggleFavorite, // Toggle favorite state
                  icon: Icon(
                    isFavorited ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  label: Text(
                      isFavorited ? 'Quitar de favoritos' : 'Añadir a favoritos'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
