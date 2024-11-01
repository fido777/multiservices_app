import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multiservices_app/splash/splash_screen.dart';
import 'package:multiservices_app/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiservicios N & D',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [
        Locale("es", "CO"),
        Locale("en", "US"),
      ],
      //locale: const Locale("es", "CO"),
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF50C2C9)),
      //   useMaterial3: true,
      // ),
      themeMode: ThemeMode.system,
      darkTheme: MaterialTheme.dark(),
      theme: MaterialTheme.light(),
      home: const SplashScreen(),
    );
  }
}
