import 'package:flutter/material.dart';
import 'package:travel_bagage_app/widgets/glass_bottom_nav_bar.dart';
import 'package:travel_bagage_app/screens/trips_list_screen.dart';
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
    const TripsListScreen(), // Accueil
    const _SearchScreen(), // Recherche
    const _AddTripScreen(), // Ajouter
    const _MessagesScreen(), // Messages
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

// Écrans temporaires (à remplacer par vos vrais écrans)

class _SearchScreen extends StatelessWidget {
  const _SearchScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rechercher un voyage'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Recherche',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddTripScreen extends StatelessWidget {
  const _AddTripScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un voyage'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle, size: 80, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'Ajouter un voyage',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessagesScreen extends StatelessWidget {
  const _MessagesScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Messages',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

