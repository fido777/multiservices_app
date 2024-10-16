import 'package:flutter/material.dart';
import 'package:multiservices_app/main/home/home_screen.dart';
import 'package:multiservices_app/main/jobs_listing/jobs_listing_screen.dart';
import 'package:multiservices_app/main/profile/profile_screen.dart';


class NavigationBarMenu extends StatefulWidget {
  const NavigationBarMenu({super.key});

  @override
  State<NavigationBarMenu> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarMenu> {

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    JobsListingScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Multiservicios N&D"),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: "Listado de Trabajos"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Mi Pérfil"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped
      ),
    );
  }
}
