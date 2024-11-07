import 'dart:developer';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log("Accedido a HomeScreen", level: 200, name: "HomeScreen.build()");
    return const Center(
      child: Text("Home Screen"),
    );
  }
}