import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:multiservices_app/main/home/home_screen.dart';
import 'package:multiservices_app/main/jobs_listing/jobs_listing_screen.dart';
import 'package:multiservices_app/main/profile/profile_screen.dart';
import 'package:multiservices_app/model/user.dart';
import 'package:multiservices_app/repository/favorites_crud.dart';

class NavigationBarMenu extends StatefulWidget {
  const NavigationBarMenu({super.key});

  @override
  State<NavigationBarMenu> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarMenu> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    HomeScreen(),
    JobsListingScreen(),
    ProfileScreen()
  ];
  
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _openFavoritesBox();
  }

  Future<void> _openFavoritesBox() async {
    final user = _auth.currentUser;
    if (user != null) {
      // Initialize the user's specific Hive box for favorites
      await Hive.openBox<User>('favorites_${user.uid}');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
            BottomNavigationBarItem(
                icon: Icon(Icons.list), label: "Listado de Trabajos"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Mi Pérfil"),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped),
    );
  }
}
