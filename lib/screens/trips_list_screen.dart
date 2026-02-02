import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:travel_bagage_app/data/models/trip_model.dart';
import 'package:travel_bagage_app/screens/trip_details_screen.dart';
import 'package:travel_bagage_app/screens/user_profile_screen.dart';
import 'package:travel_bagage_app/screens/search_trips_screen.dart';
import 'package:travel_bagage_app/widgets/bottom_nav_spacer.dart';

class TripsListScreen extends StatefulWidget {
  const TripsListScreen({super.key});

  @override
  State<TripsListScreen> createState() => _TripsListScreenState();
}

class _TripsListScreenState extends State<TripsListScreen> {
  final List<TripModel> _trips = [
    TripModel(
      id: '1',
      userId: 'user1',
      userName: 'Jean Dupont',
      departureCity: 'Paris',
      departureCountry: 'France',
      arrivalCity: 'Dakar',
      arrivalCountry: 'Sénégal',
      departureDate: DateTime.now().add(const Duration(days: 15)),
      arrivalDate: DateTime.now().add(const Duration(days: 16)),
      availableWeight: 10.0,
      pricePerKg: 5.0,
      description: 'Voyage professionnel, je peux transporter des colis légers',
    ),
    TripModel(
      id: '2',
      userId: 'user2',
      userName: 'Marie Martin',
      departureCity: 'Lyon',
      departureCountry: 'France',
      arrivalCity: 'Abidjan',
      arrivalCountry: 'Côte d\'Ivoire',
      departureDate: DateTime.now().add(const Duration(days: 20)),
      arrivalDate: DateTime.now().add(const Duration(days: 21)),
      availableWeight: 15.0,
      pricePerKg: 4.5,
      description: 'Retour au pays, disponible pour transporter documents et vêtements',
    ),
    TripModel(
      id: '3',
      userId: 'user3',
      userName: 'Ahmed Diallo',
      departureCity: 'Marseille',
      departureCountry: 'France',
      arrivalCity: 'Bamako',
      arrivalCountry: 'Mali',
      departureDate: DateTime.now().add(const Duration(days: 10)),
      arrivalDate: DateTime.now().add(const Duration(days: 11)),
      availableWeight: 8.0,
      pricePerKg: 6.0,
      description: 'Visite familiale',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voyages disponibles'),
        actions: [
          IconButton(
            icon: const Icon(IconlyLight.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchTripsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(IconlyLight.filter),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: _trips.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _trips.length + 1,
              itemBuilder: (context, index) {
                if (index == _trips.length) {
                  return const BottomNavSpacer();
                }
                return _buildTripCard(_trips[index]);
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
            IconlyLight.send,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Aucun voyage disponible',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripCard(TripModel trip) {
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
              builder: (context) => TripDetailsScreen(trip: trip),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête : Trajet principal
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Ville de départ
                        Text(
                          trip.departureCity,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          trip.departureCountry,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Icône avion
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      IconlyBold.send,
                      color: Colors.blue[700],
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Ville d'arrivée
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          trip.arrivalCity,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          trip.arrivalCountry,
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

              // Divider
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Divider(
                  height: 1,
                  color: Colors.grey[200],
                ),
              ),

              // Informations du voyage
              Row(
                children: [
                  // Avatar et nom
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(
                            userId: trip.userId,
                            userName: trip.userName,
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.blue[50],
                      child: Text(
                        trip.userName[0].toUpperCase(),
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      trip.userName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  // Date
                  Icon(
                    IconlyLight.calendar,
                    size: 14,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${trip.departureDate.day}/${trip.departureDate.month}/${trip.departureDate.year}',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Poids et prix
              Row(
                children: [
                  // Poids disponible
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            IconlyLight.bag2,
                            size: 16,
                            color: Colors.grey[700],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${trip.availableWeight} kg',
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
                  // Prix
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${trip.pricePerKg} €/kg',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
                    icon: const Icon(IconlyLight.closeSquare),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(IconlyLight.swap),
                title: const Text('Trier par prix'),
                trailing: const Icon(IconlyLight.arrowRight2),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement price sorting
                },
              ),
              ListTile(
                leading: const Icon(IconlyLight.calendar),
                title: const Text('Trier par date'),
                trailing: const Icon(IconlyLight.arrowRight2),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement date sorting
                },
              ),
              ListTile(
                leading: const Icon(IconlyLight.bag2),
                title: const Text('Trier par poids disponible'),
                trailing: const Icon(IconlyLight.arrowRight2),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement weight sorting
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
