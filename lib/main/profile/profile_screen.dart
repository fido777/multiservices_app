import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiservices_app/repository/firebase_api.dart';
import 'package:multiservices_app/auth/login/login_screen.dart';
import 'package:multiservices_app/model/user.dart' as user_model;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  user_model.User? _user; // Variable para almacenar los datos del usuario
  bool _isLoading = true;
  final ImagePicker _picker =
      ImagePicker(); // ImagePicker para seleccionar imagen

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

  /// Selecciona y sube la imagen a Firebase Storage, y actualiza el modelo del
  /// usuario con la url de la imagen
  Future<void> _uploadProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Subir imagen a Firebase Storage
      String? downloadURL = await uploadProfileImage(imageFile, userId);

      // Actualizar URL de imagen en Firestore y en el modelo
      FirebaseApi api = FirebaseApi();
      await api.updateUserImageUrl(userId, downloadURL);

      setState(() {
        _user?.imageUrl = downloadURL;
      });
    }
  }

  /// Sube la imagen de perfil a Firebase Storage
  Future<String?> uploadProfileImage(File imageFile, String userId) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('profile_images/$userId.jpg');
      await storageRef.putFile(imageFile);
      final downloadURL = await storageRef.getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      log("Ocurrió un error al subir la imagen a Firebase. StorageException ${e.code}", level: 1000, name: "FirebaseApi.uploadProfileImage()");
      return null;
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
                        // Mostrar imagen de perfil o un placeholder si no hay imagen
                        GestureDetector(
                          onTap: _uploadProfileImage, // Subir imagen al tocar
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _user!.imageUrl != null
                                ? NetworkImage(_user!.imageUrl!)
                                : const AssetImage(
                                        'assets/images/avatar_placeholder.png')
                                    as ImageProvider,
                          ),
                        ),
                        const SizedBox(height: 10),
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
              : Center(
                  child: Column(
                    children: [
                      const Text("Error al cargar el perfil"),
                      FilledButton(
                        onPressed: () => _onButtonClicked(context),
                        child: const Text("Cerrar sesión"),
                      ),
                    ],
                  ),
                ),
    );
  }

  void _onButtonClicked(BuildContext context) {
    FirebaseAuth.instance.signOut().then((_) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));

      log("Sesión cerrada con éxito", level: 200);
    });
  }
}
