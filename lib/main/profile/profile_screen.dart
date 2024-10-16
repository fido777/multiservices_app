import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiservices_app/auth/login/login_screen.dart';
import 'package:multiservices_app/model/user.dart' as user_model;
import 'package:multiservices_app/repository/firebase_api.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  user_model.User? _user; // Variable para almacenar los datos del usuario
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Cargar los datos del usuario cuando la pantalla se inicializa
  }

  Future<void> _loadUserData() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      FirebaseApi api = FirebaseApi();
      user_model.User? user = await api.getUserFromFirestoreById(uid);

      if (mounted) {
        setState(() {
          _user = user;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Perfil")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _user != null
              ? Center(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('UUID: ${_user!.uuid}'),
                        Text('Nombre: ${_user!.name}'),
                        Text('Email: ${_user!.email}'),
                        const SizedBox(height: 20),
                        FilledButton(
                          onPressed: () => _onButtonClicked(context),
                          child: const Text("Cerrar sesión"),
                        ),
                      ],
                    ),
                  ),
              )
              : const Center(child: Text("Error al cargar el perfil")),
    );
  }

  void _onButtonClicked(BuildContext context) {
    FirebaseAuth.instance.signOut().then((_) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));

      print("Sesión cerrada con éxito");
    });
  }
}
