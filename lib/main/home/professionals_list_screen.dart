import 'package:flutter/material.dart';
import 'package:multiservices_app/main/home/profile_details_screen.dart';
import 'package:multiservices_app/model/user.dart' as user_model;
import 'package:multiservices_app/repository/firebase_api.dart';
import 'package:multiservices_app/utils/assets.dart';

class ProfessionalsListScreen extends StatelessWidget {
  final String profession;

  const ProfessionalsListScreen({super.key, required this.profession});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          profession,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        elevation: 4,
      ),
      body: FutureBuilder<List<user_model.User>>(
        future: _getProfessionals(profession),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No hay profesionales para esta profesión.',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
              ),
            );
          }

          final professionals = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: professionals.length,
            itemBuilder: (context, index) {
              final user = professionals[index];
              return _buildProfessionalCard(context, user);
            },
          );
        },
      ),
    );
  }

  Future<List<user_model.User>> _getProfessionals(String profession) async {
    final firebaseApi = FirebaseApi();
    return await firebaseApi.getProfessionalsByProfession(profession);
  }

  Widget _buildProfessionalCard(BuildContext context, user_model.User user) {
    return GestureDetector(
      onTap: () {
        // Navigate to ProfileDetailsScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileDetailsScreen(user: user),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Profile Image
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: user.imageUrl != null
                    ? NetworkImage(user.imageUrl!)
                    : AssetImage(Assets.avatarPlaceholder) as ImageProvider,
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
            ],
          ),
        ),
      ),
    );
  }
}
