import 'package:flutter/material.dart';
import 'package:multiservices_app/model/user.dart' as user_model;
import 'package:multiservices_app/utils/assets.dart';

class ProfileDetailsScreen extends StatelessWidget {
  final user_model.User user;

  const ProfileDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.name,
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
            // Profile Image
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: user.imageUrl != null
                    ? NetworkImage(user.imageUrl!)
                    : AssetImage(Assets.avatarPlaceholder) as ImageProvider,
              ),
            ),
            const SizedBox(height: 16),

            // Details
            Text(
              'Name: ${user.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'City: ${user.city}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Email: ${user.email}',
              style: TextStyle(fontSize: 16, color: Colors.blue.shade400),
            ),
            const SizedBox(height: 8),
            // Additional details can be added here
            Text(
              'Phone: ${user.phone ?? 'No disponible'}',
              style: TextStyle(fontSize: 16, color: Colors.green.shade400),
            ),
            const SizedBox(height: 8),
            Text(
              'Profession: ${user.profession}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
