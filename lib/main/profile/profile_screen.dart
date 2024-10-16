import 'package:flutter/material.dart';
import 'package:multiservices_app/auth/login/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Profile Screen"),
          FilledButton(
              onPressed: () => _onButtonClicked(context),
              child: const Text("Cerrar sesión"))
        ],
      ),
    );
  }

  void _onButtonClicked(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
