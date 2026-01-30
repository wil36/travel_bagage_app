import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:travel_bagage_app/screens/declare_trip_screen.dart';
import 'package:travel_bagage_app/screens/declare_package_screen.dart';
import 'package:travel_bagage_app/screens/trips_list_screen.dart';
import 'package:travel_bagage_app/screens/search/search_screen.dart';
import 'package:travel_bagage_app/screens/profile/profile_screen.dart';
import 'package:travel_bagage_app/screens/notifications_screen.dart';
import 'package:travel_bagage_app/widgets/bottom_nav_spacer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const TripsListScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     border: Border(
      //       top: BorderSide(color: Colors.grey[200]!, width: 1),
      //     ),
      //   ),
      //   child: BottomNavigationBar(
      //     currentIndex: _selectedIndex,
      //     onTap: (index) {
      //       setState(() {
      //         _selectedIndex = index;
      //       });
      //     },
      //     type: BottomNavigationBarType.fixed,
      //     selectedItemColor: Colors.blue,
      //     unselectedItemColor: Colors.grey,
      //     selectedFontSize: 12,
      //     unselectedFontSize: 12,
      //     elevation: 0,
      //     items: const [
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.home_outlined),
      //         activeIcon: Icon(Icons.home),
      //         label: 'Accueil',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.flight_outlined),
      //         activeIcon: Icon(Icons.flight),
      //         label: 'Voyages',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.search_outlined),
      //         activeIcon: Icon(Icons.search),
      //         label: 'Recherche',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.person_outlined),
      //         activeIcon: Icon(Icons.person),
      //         label: 'Profil',
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset("assets/images/logo.png", width: 40, height: 40),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(IconlyLight.notification),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationsScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bonjour, John',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Que souhaitez-vous faire aujourd\'hui ?',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            _buildActionCard(
              context,
              title: 'Déclarer un voyage',
              subtitle: 'Gagnez de l\'argent en transportant',
              icon: IconlyLight.send,
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeclareTripScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildActionCard(
              context,
              title: 'Publier un colis',
              subtitle: 'Trouvez un voyageur pour votre envoi',
              icon: IconlyLight.bag,
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeclarePackageScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Statistiques',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(onPressed: () {}, child: const Text('Voir tout')),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: IconlyBold.send,
                    title: 'Voyages',
                    value: '3',
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    icon: IconlyBold.bag,
                    title: 'Colis',
                    value: '5',
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: IconlyBold.star,
                    title: 'Note',
                    value: '4.8',
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    icon: IconlyBold.wallet,
                    title: 'Gains',
                    value: '520€',
                    color: Colors.green,
                  ),
                ),
              ],
            ),
      
            // Spacer pour éviter que le contenu soit caché par la navbar
            const BottomNavSpacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                IconlyLight.arrowRight2,
                color: Colors.grey[400],
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
