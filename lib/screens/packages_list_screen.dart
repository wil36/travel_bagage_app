import 'package:flutter/material.dart';
import 'package:travel_bagage_app/models/package_model.dart';
import 'package:travel_bagage_app/screens/package_details_screen.dart';
import 'package:travel_bagage_app/screens/user_profile_screen.dart';
import 'package:travel_bagage_app/widgets/bottom_nav_spacer.dart';

class PackagesListScreen extends StatefulWidget {
  const PackagesListScreen({super.key});

  @override
  State<PackagesListScreen> createState() => _PackagesListScreenState();
}

class _PackagesListScreenState extends State<PackagesListScreen> {
  final List<PackageModel> _packages = [
    PackageModel(
      id: '1',
      senderId: 'user1',
      senderName: 'Sophie Bernard',
      departureCity: 'Paris',
      departureCountry: 'France',
      arrivalCity: 'Dakar',
      arrivalCountry: 'Sénégal',
      neededByDate: DateTime.now().add(const Duration(days: 10)),
      weight: 5.0,
      offeredPrice: 25.0,
      description: 'Documents importants à envoyer à ma famille',
      category: 'documents',
    ),
    PackageModel(
      id: '2',
      senderId: 'user2',
      senderName: 'Ahmed Diallo',
      departureCity: 'Marseille',
      departureCountry: 'France',
      arrivalCity: 'Bamako',
      arrivalCountry: 'Mali',
      neededByDate: DateTime.now().add(const Duration(days: 15)),
      weight: 8.0,
      offeredPrice: 50.0,
      description: 'Vêtements pour enfants et jouets',
      category: 'vêtements',
    ),
    PackageModel(
      id: '3',
      senderId: 'user3',
      senderName: 'Marie Kouassi',
      departureCity: 'Lyon',
      departureCountry: 'France',
      arrivalCity: 'Abidjan',
      arrivalCountry: 'Côte d\'Ivoire',
      neededByDate: DateTime.now().add(const Duration(days: 20)),
      weight: 3.0,
      offeredPrice: 20.0,
      description: 'Produits cosmétiques et médicaments',
      category: 'autre',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colis disponibles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              _showSearchDialog();
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: _packages.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _packages.length + 1,
              itemBuilder: (context, index) {
                if (index == _packages.length) {
                  return const BottomNavSpacer();
                }
                return _buildPackageCard(_packages[index]);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Aucun colis disponible',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageCard(PackageModel package) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PackageDetailsScreen(package: package),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête : Trajet
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          package.departureCity,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          package.departureCountry,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.inventory_2_rounded,
                      color: Colors.orange[700],
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          package.arrivalCity,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          package.arrivalCountry,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Divider(height: 1, color: Colors.grey[200]),
              ),

              // Informations de l'expéditeur
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(
                            userId: package.userId,
                            userName: package.userName,
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.orange[50],
                      child: Text(
                        package.userName[0].toUpperCase(),
                        style: TextStyle(
                          color: Colors.orange[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      package.userName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 14,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${package.neededByDate.day}/${package.neededByDate.month}/${package.neededByDate.year}',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Catégorie
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCategoryColor(package.category).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getCategoryIcon(package.category),
                      size: 14,
                      color: _getCategoryColor(package.category),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getCategoryLabel(package.category),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getCategoryColor(package.category),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Poids et prix
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.scale_outlined,
                            size: 16,
                            color: Colors.grey[700],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${package.weight} kg',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${package.offeredPrice} €',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Description
              Text(
                package.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'documents':
        return Icons.description_outlined;
      case 'vêtements':
        return Icons.checkroom_outlined;
      case 'électronique':
        return Icons.devices_outlined;
      default:
        return Icons.category_outlined;
    }
  }

  String _getCategoryLabel(String category) {
    switch (category) {
      case 'documents':
        return 'Documents';
      case 'vêtements':
        return 'Vêtements';
      case 'électronique':
        return 'Électronique';
      default:
        return 'Autre';
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'documents':
        return Colors.blue;
      case 'vêtements':
        return Colors.purple;
      case 'électronique':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final departureCityController = TextEditingController();
        final arrivalCityController = TextEditingController();

        return AlertDialog(
          title: const Text('Rechercher un colis'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: departureCityController,
                  decoration: const InputDecoration(
                    labelText: 'Ville de départ',
                    prefixIcon: Icon(Icons.flight_takeoff_rounded),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: arrivalCityController,
                  decoration: const InputDecoration(
                    labelText: 'Ville d\'arrivée',
                    prefixIcon: Icon(Icons.flight_land_rounded),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // TODO: Implement search functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Recherche en cours...'),
                  ),
                );
              },
              child: const Text('Rechercher'),
            ),
          ],
        );
      },
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filtres',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.euro_rounded),
                title: const Text('Trier par prix'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement price sorting
                },
              ),
              ListTile(
                leading: const Icon(Icons.scale_rounded),
                title: const Text('Trier par poids'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement weight sorting
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today_rounded),
                title: const Text('Trier par date limite'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement date sorting
                },
              ),
              ListTile(
                leading: const Icon(Icons.category_rounded),
                title: const Text('Filtrer par catégorie'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement category filter
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
