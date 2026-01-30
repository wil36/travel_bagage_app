import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:travel_bagage_app/models/trip_model.dart';
import 'package:travel_bagage_app/models/package_model.dart';
import 'package:travel_bagage_app/screens/trip_details_screen.dart';
import 'package:travel_bagage_app/screens/package_details_screen.dart';

class ActivitySummaryScreen extends StatefulWidget {
  const ActivitySummaryScreen({super.key});

  @override
  State<ActivitySummaryScreen> createState() => _ActivitySummaryScreenState();
}

class _ActivitySummaryScreenState extends State<ActivitySummaryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<TripModel> _myTrips = [
    TripModel(
      id: '1',
      userId: 'user123',
      userName: 'John Doe',
      departureCity: 'Paris',
      departureCountry: 'France',
      arrivalCity: 'Dakar',
      arrivalCountry: 'Sénégal',
      departureDate: DateTime.now().add(const Duration(days: 5)),
      arrivalDate: DateTime.now().add(const Duration(days: 6)),
      availableWeight: 10.0,
      pricePerKg: 5.0,
      description: 'Voyage professionnel',
      status: TripStatus.active,
    ),
    TripModel(
      id: '2',
      userId: 'user123',
      userName: 'John Doe',
      departureCity: 'Lyon',
      departureCountry: 'France',
      arrivalCity: 'Abidjan',
      arrivalCountry: 'Côte d\'Ivoire',
      departureDate: DateTime.now().subtract(const Duration(days: 30)),
      arrivalDate: DateTime.now().subtract(const Duration(days: 29)),
      availableWeight: 8.0,
      pricePerKg: 6.0,
      description: 'Visite familiale',
      status: TripStatus.completed,
    ),
  ];

  final List<PackageModel> _myPackages = [
    PackageModel(
      id: '1',
      senderId: 'user123',
      senderName: 'John Doe',
      departureCity: 'Paris',
      departureCountry: 'France',
      arrivalCity: 'Bamako',
      arrivalCountry: 'Mali',
      weight: 3.0,
      description: 'Documents importants',
      category: 'Documents',
      offeredPrice: 20.0,
      neededByDate: DateTime.now().add(const Duration(days: 10)),
      status: PackageStatus.pending,
    ),
    PackageModel(
      id: '2',
      senderId: 'user123',
      senderName: 'John Doe',
      departureCity: 'Marseille',
      departureCountry: 'France',
      arrivalCity: 'Tunis',
      arrivalCountry: 'Tunisie',
      weight: 5.0,
      description: 'Vêtements et cadeaux',
      category: 'Vêtements',
      offeredPrice: 35.0,
      neededByDate: DateTime.now().subtract(const Duration(days: 5)),
      status: PackageStatus.delivered,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes activités'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          tabs: const [
            Tab(text: 'Mes voyages'),
            Tab(text: 'Mes colis'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTripsTab(),
          _buildPackagesTab(),
        ],
      ),
    );
  }

  Widget _buildTripsTab() {
    final activeTrips =
        _myTrips.where((t) => t.status == TripStatus.active).toList();
    final completedTrips =
        _myTrips.where((t) => t.status == TripStatus.completed).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsCard(
            'Voyages actifs',
            activeTrips.length.toString(),
            Colors.blue,
          ),
          const SizedBox(height: 16),
          if (activeTrips.isNotEmpty) ...[
            const Text(
              'Voyages en cours',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...activeTrips.map((trip) => _buildTripCard(trip)),
            const SizedBox(height: 16),
          ],
          if (completedTrips.isNotEmpty) ...[
            const Text(
              'Voyages terminés',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...completedTrips.map((trip) => _buildTripCard(trip)),
          ],
        ],
      ),
    );
  }

  Widget _buildPackagesTab() {
    final pendingPackages =
        _myPackages.where((p) => p.status == PackageStatus.pending).toList();
    final deliveredPackages =
        _myPackages.where((p) => p.status == PackageStatus.delivered).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsCard(
            'Colis en attente',
            pendingPackages.length.toString(),
            Colors.orange,
          ),
          const SizedBox(height: 16),
          if (pendingPackages.isNotEmpty) ...[
            const Text(
              'En attente de transporteur',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...pendingPackages.map((package) => _buildPackageCard(package)),
            const SizedBox(height: 16),
          ],
          if (deliveredPackages.isNotEmpty) ...[
            const Text(
              'Colis livrés',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...deliveredPackages.map((package) => _buildPackageCard(package)),
          ],
        ],
      ),
    );
  }

  Widget _buildStatsCard(String label, String value, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
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
        border: Border.all(color: Colors.grey[200]!),
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(IconlyLight.send, size: 20, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${trip.departureCity} → ${trip.arrivalCity}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusChip(trip.status),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${trip.departureDate.day}/${trip.departureDate.month}/${trip.departureDate.year}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Text(
                '${trip.availableWeight} kg disponibles • ${trip.pricePerKg} €/kg',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackageCard(PackageModel package) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
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
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(IconlyLight.bag,
                            size: 20, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${package.departureCity} → ${package.arrivalCity}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildPackageStatusChip(package.status),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                package.description,
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(height: 4),
              Text(
                '${package.weight} kg • ${package.offeredPrice} €',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(TripStatus status) {
    Color color;
    String text;

    switch (status) {
      case TripStatus.active:
        color = Colors.green;
        text = 'Actif';
        break;
      case TripStatus.completed:
        color = Colors.grey;
        text = 'Terminé';
        break;
      case TripStatus.cancelled:
        color = Colors.red;
        text = 'Annulé';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPackageStatusChip(PackageStatus status) {
    Color color;
    String text;

    switch (status) {
      case PackageStatus.pending:
        color = Colors.orange;
        text = 'En attente';
        break;
      case PackageStatus.inTransit:
        color = Colors.purple;
        text = 'En transit';
        break;
      case PackageStatus.delivered:
        color = Colors.green;
        text = 'Livré';
        break;
      case PackageStatus.cancelled:
        color = Colors.red;
        text = 'Annulé';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
