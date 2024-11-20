import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiservices_app/repository/firebase_api.dart';
import 'package:multiservices_app/auth/login/login_screen.dart';
import 'package:multiservices_app/model/user.dart' as user_model;
import 'package:multiservices_app/utils/assets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  user_model.User? _user;
  bool _isLoading = true;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
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

  Future<void> _uploadProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String userId = FirebaseAuth.instance.currentUser!.uid;

      String? downloadURL = await uploadProfileImage(imageFile, userId);

      FirebaseApi api = FirebaseApi();
      await api.updateUserImageUrl(userId, downloadURL);

      setState(() {
        _user?.imageUrl = downloadURL;
      });
    }
  }

  Future<String?> uploadProfileImage(File imageFile, String userId) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('profile_images/$userId.jpg');
      await storageRef.putFile(imageFile);
      final downloadURL = await storageRef.getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      log("Error uploading image to Firebase: ${e.code}",
          level: 1000, name: "FirebaseApi.uploadProfileImage()");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    log("Accedido a ProfileScreen", level: 200, name: "ProfileScreen.build()");

    return Scaffold(
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _user == null
                ? const Center(child: Text("Error al cargar el perfil"))
                : Scaffold(
                    appBar: AppBar(
                      title: const Text("Perfil"),
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      centerTitle: true,
                      elevation: 4,
                    ),
                    body: Stack(children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                // First Rectangle (Profile info with background color)
                                Container(
                                  width: double.infinity,
                                  height: 260,
                                  color: Theme.of(context).colorScheme.primary,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Profile picture
                                      GestureDetector(
                                        onTap: _uploadProfileImage,
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.white,
                                          backgroundImage: _user!.imageUrl !=
                                                  null
                                              ? NetworkImage(_user!.imageUrl!)
                                              : const AssetImage(
                                                      'assets/images/avatar_placeholder.png')
                                                  as ImageProvider,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // User Name
                                      Text(
                                        _user!.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // User Email
                                      Text(
                                        _user!.email,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Second Rectangle (City, Profession, Contact)
                                Positioned(
                                  left: 16,
                                  right: 16,
                                  top: 220,
                                  child: Center(
                                    child: Container(
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceTint,
                                        borderRadius: BorderRadius.zero,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const SizedBox(
                                            width: 40,
                                          ),
                                          // City Info
                                          _buildInfoColumn(
                                            icon: Icons.location_city,
                                            label: 'Ciudad',
                                            value: _user!.city,
                                          ),

                                          // Vertical Divider
                                          _verticalDivider(),

                                          // Profession Info
                                          _buildInfoColumn(
                                            icon: Icons.work,
                                            label: 'Profesión',
                                            value: _user!.profession ??
                                                'No disponible',
                                          ),

                                          // Vertical Divider
                                          _verticalDivider(),

                                          // Contact Action
                                          GestureDetector(
                                              onTap: () {
                                                // Add logic to contact professional here
                                              },
                                              child: Row(children: [
                                                // Add an Icon of Icons.contact_page_rounded and an icon of Icons.arrow_right_sharp
                                                Icon(Icons.contact_page_rounded,
                                                    size: 46,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSecondary),
                                                const SizedBox(width: 4),
                                                Icon(Icons.arrow_right_sharp,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSecondary),
                                              ])),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                                height: 70), // Space below the second rectangle

                            // Menu Options
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                children: [
                                  _buildMenuOption(
                                    icon: Icons.star_rounded,
                                    text: 'Favoritos',
                                    onTap: () {},
                                  ),
                                  _buildMenuOption(
                                    icon: Icons.privacy_tip,
                                    text: 'Política de privacidad',
                                    onTap: () {},
                                  ),
                                  _buildMenuOption(
                                    icon: Icons.settings,
                                    text: 'Ajustes',
                                    onTap: () {},
                                  ),
                                  _buildMenuOption(
                                    icon: Icons.help,
                                    text: 'Ayuda',
                                    onTap: () {},
                                  ),
                                  _buildMenuOption(
                                    icon: Icons.logout,
                                    text: 'Cerrar sesión',
                                    onTap: () =>
                                        _onCloseSesionButtonClicked(context),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: SvgPicture.asset(
                          Assets.lightCirclesImage,
                        ),
                      ),
                    ]),
                  ));
  }

  Widget _buildInfoColumn(
      {required IconData icon, required String label, required String value}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.onSecondary),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
              fontSize: 14, color: Theme.of(context).colorScheme.onSecondary),
        ),
      ],
    );
  }

  Widget _buildMenuOption(
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return ListTile(
      leading:
          Icon(icon, color: Theme.of(context).colorScheme.primaryContainer),
      trailing: Icon(Icons.arrow_right_sharp,
          size: 32, color: Theme.of(context).colorScheme.secondary),
      title: Text(text, style: const TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }

  Widget _verticalDivider() => VerticalDivider(
        color: Theme.of(context).colorScheme.onSecondary,
        thickness: 1.5,
        width: 20, // Space between items and divider
        indent: 10, // Top padding
        endIndent: 10, // Bottom padding
      );

  void _onCloseSesionButtonClicked(BuildContext context) {
    try {
      FirebaseAuth.instance.signOut().then((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
        log("Sesión cerrada con éxito",
            level: 200, name: '_onCloseSesionButtonClicked()');
      });
    } catch (e) {
      log("Error al cerrar sesión",
          level: 1000, name: '_onCloseSesionButtonClicked()');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }
}
