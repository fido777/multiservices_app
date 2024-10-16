import 'package:flutter/material.dart';
import 'package:multiservices_app/auth/login/login_screen.dart';
import 'package:multiservices_app/utils/assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiservices_app/widgets/navigation_bar_menu.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _closeSplash() async {
    Future.delayed(const Duration(seconds: 2), () async {
      // Navegar a Login o a NavigationBar si hay o no un usuario activo
      FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
        if (user == null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const NavigationBarMenu()));
        }
      });    });
  }

  @override
  void initState() {
    _closeSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(Assets.logoName),
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
