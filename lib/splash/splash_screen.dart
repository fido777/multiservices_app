import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:multiservices_app/auth/login/login_screen.dart';
import 'package:multiservices_app/utils/assets.dart';
import 'package:multiservices_app/widgets/navigation_bar_menu.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebasePerformance _performance = FirebasePerformance.instance;
  late Trace _splashTrace;

  Future<void> _closeSplash() async {
    Future.delayed(const Duration(seconds: 2), () async {
      // Navegar a Login o a NavigationBar si hay o no un usuario activo
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NavigationBarMenu()),
          );
        }
        // Termina la traza al finalizar la navegación
        _splashTrace.stop();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startSplashTrace();
    _closeSplash();
  }

  Future<void> _startSplashTrace() async {
    _splashTrace = _performance.newTrace('splash_screen_load_trace');
    await _splashTrace.start();
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
