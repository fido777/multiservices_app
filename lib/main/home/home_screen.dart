import 'package:flutter/material.dart';
import 'package:multiservices_app/utils/lists.dart' as lists;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profesiones"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: lists.professions.length,
          itemBuilder: (context, index) {
            final profession = lists.professions[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProfessionDetailScreen(profession: profession),
                  ),
                );
              },
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                elevation: 0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  leading: const Icon(
                    Icons.work_outline,
                    color: Colors.blueAccent,
                    size: 40,
                  ),
                  title: Text(
                    profession,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 18,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Method to get a custom icon for each profession
  IconData _getProfessionIcon(String profession) {
    switch (profession.toLowerCase()) {
      case 'doctor':
        return Icons.medical_services;
      case 'engineer':
        return Icons.engineering;
      case 'teacher':
        return Icons.school;
      case 'artist':
        return Icons.brush;
      case 'chef':
        return Icons.restaurant;
      case 'mechanic':
        return Icons.build;
      case 'architect':
        return Icons.architecture;
      case 'nurse':
        return Icons.local_hospital;
      case 'scientist':
        return Icons.science;
      case 'photographer':
        return Icons.camera_alt;
      case 'lawyer':
        return Icons.gavel;
      default:
        return Icons.work_outline;
    }
  }
}

class ProfessionDetailScreen extends StatelessWidget {
  final String profession;

  const ProfessionDetailScreen({super.key, required this.profession});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(profession),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Details about $profession',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
