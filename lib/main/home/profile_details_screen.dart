import 'package:flutter/material.dart';
import 'package:multiservices_app/model/user.dart';
import 'package:multiservices_app/utils/assets.dart';

import 'package:hive/hive.dart';

class ProfileDetailsScreen extends StatefulWidget {
  final User user;

  const ProfileDetailsScreen({super.key, required this.user});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  late Box<User> favoritesBox;
  late bool isFavorited;

  @override
  void initState() {
    super.initState();
    favoritesBox = Hive.box<User>('favorites');
    isFavorited = favoritesBox.containsKey(widget.user.uuid);
  }

  void toggleFavorite() {
    setState(() {
      if (isFavorited) {
        favoritesBox.delete(widget.user.uuid);
      } else {
        favoritesBox.put(widget.user.uuid, widget.user);
      }
      isFavorited = !isFavorited; // Update the state
    });
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
            ElevatedButton.icon(
              onPressed: toggleFavorite, // Toggle favorite state
              icon: Icon(
                isFavorited ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              label: Text(isFavorited ? 'Quitar de favoritos' : 'Añadir a favoritos'),
            ),
          ],
        ),
      ),
    );
  }
}
