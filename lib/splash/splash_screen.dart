import 'package:flutter/material.dart';
import 'package:multiservices_app/auth/login/login_screen.dart';
import 'package:multiservices_app/utils/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _closeSplash() async {
    Future.delayed(const Duration(seconds: 2), () async {
      // Navegar a Login
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
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
