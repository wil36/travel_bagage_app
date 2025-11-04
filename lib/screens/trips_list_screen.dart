import 'package:flutter/material.dart';
import 'package:travel_bagage_app/models/trip_model.dart';
import 'package:travel_bagage_app/screens/trip_details_screen.dart';

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
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implémenter les filtres
            },
          ),
        ],
      ),
      body: _trips.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _trips.length,
              itemBuilder: (context, index) {
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
            Icons.flight_takeoff,
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
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
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
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue[100],
                    child: Text(
                      trip.userName[0].toUpperCase(),
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trip.userName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${trip.availableWeight} kg disponibles',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${trip.pricePerKg} €/kg',
                      style: TextStyle(
                        color: Colors.green[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.flight_takeoff,
                              size: 20,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${trip.departureCity}, ${trip.departureCountry}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.flight_land,
                              size: 20,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${trip.arrivalCity}, ${trip.arrivalCountry}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${trip.departureDate.day}/${trip.departureDate.month}/${trip.departureDate.year}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              if (trip.description.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  trip.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
