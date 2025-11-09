import 'package:flutter/material.dart';
import 'package:travel_bagage_app/widgets/glass_bottom_nav_bar.dart';
import 'package:travel_bagage_app/screens/home_screen.dart';
import 'package:travel_bagage_app/screens/trips_list_screen.dart';
import 'package:travel_bagage_app/screens/packages_list_screen.dart';
import 'package:travel_bagage_app/screens/messages_list_screen.dart';
import 'package:travel_bagage_app/screens/profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Liste des écrans pour chaque onglet
  final List<Widget> _screens = [
    const HomePage(), // Accueil
    const TripsListScreen(), // Voyages disponibles
    const PackagesListScreen(), // Colis disponibles
    const MessagesListScreen(), // Messages
    const ProfileScreen(), // Profil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Permet au body de s'étendre sous la navbar
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: GlassBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

