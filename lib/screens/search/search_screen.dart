import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:travel_bagage_app/models/trip_model.dart';
import 'package:travel_bagage_app/screens/trip_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _departureCityController = TextEditingController();
  final _arrivalCityController = TextEditingController();
  DateTime? _selectedDate;
  double _maxWeight = 20.0;
  double _maxPrice = 10.0;

  List<TripModel> _searchResults = [];
  bool _isSearching = false;

  final List<TripModel> _allTrips = [
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
      description: 'Voyage professionnel',
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
      description: 'Retour au pays',
    ),
    TripModel(
      id: '3',
      userId: 'user3',
      userName: 'Ahmed Diallo',
      departureCity: 'Paris',
      departureCountry: 'France',
      arrivalCity: 'Bamako',
      arrivalCountry: 'Mali',
      departureDate: DateTime.now().add(const Duration(days: 10)),
      arrivalDate: DateTime.now().add(const Duration(days: 11)),
      availableWeight: 8.0,
      pricePerKg: 6.0,
      description: 'Visite familiale',
    ),
    TripModel(
      id: '4',
      userId: 'user4',
      userName: 'Sophie Bernard',
      departureCity: 'Marseille',
      departureCountry: 'France',
      arrivalCity: 'Tunis',
      arrivalCountry: 'Tunisie',
      departureDate: DateTime.now().add(const Duration(days: 25)),
      arrivalDate: DateTime.now().add(const Duration(days: 26)),
      availableWeight: 12.0,
      pricePerKg: 3.5,
      description: 'Vacances',
    ),
  ];

  @override
  void dispose() {
    _departureCityController.dispose();
    _arrivalCityController.dispose();
    super.dispose();
  }

  void _performSearch() {
    setState(() {
      _isSearching = true;
      _searchResults = _allTrips.where((trip) {
        bool matchesDeparture = _departureCityController.text.isEmpty ||
            trip.departureCity
                .toLowerCase()
                .contains(_departureCityController.text.toLowerCase());

        bool matchesArrival = _arrivalCityController.text.isEmpty ||
            trip.arrivalCity
                .toLowerCase()
                .contains(_arrivalCityController.text.toLowerCase());

        bool matchesDate = _selectedDate == null ||
            (trip.departureDate.year == _selectedDate!.year &&
                trip.departureDate.month == _selectedDate!.month &&
                trip.departureDate.day == _selectedDate!.day);

        bool matchesWeight = trip.availableWeight >= _maxWeight;
        bool matchesPrice = trip.pricePerKg <= _maxPrice;

        return matchesDeparture &&
            matchesArrival &&
            matchesDate &&
            matchesWeight &&
            matchesPrice;
      }).toList();
    });
  }

  void _resetFilters() {
    setState(() {
      _departureCityController.clear();
      _arrivalCityController.clear();
      _selectedDate = null;
      _maxWeight = 20.0;
      _maxPrice = 10.0;
      _searchResults = [];
      _isSearching = false;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rechercher un trajet'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Où voulez-vous envoyer votre colis ?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _departureCityController,
                    decoration: const InputDecoration(
                      labelText: 'Ville de départ',
                      prefixIcon: Icon(IconlyLight.send),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _arrivalCityController,
                    decoration: const InputDecoration(
                      labelText: 'Ville d\'arrivée',
                      prefixIcon: Icon(IconlyLight.download),
                    ),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Date de départ souhaitée',
                        prefixIcon: Icon(IconlyLight.calendar),
                      ),
                      child: Text(
                        _selectedDate == null
                            ? 'Sélectionner une date'
                            : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                        style: TextStyle(
                          color: _selectedDate == null
                              ? Colors.grey[600]
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Filtres',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Poids minimum : ${_maxWeight.toStringAsFixed(0)} kg',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  Slider(
                    value: _maxWeight,
                    min: 0,
                    max: 50,
                    divisions: 10,
                    label: '${_maxWeight.toStringAsFixed(0)} kg',
                    onChanged: (value) {
                      setState(() {
                        _maxWeight = value;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Prix maximum : ${_maxPrice.toStringAsFixed(1)} €/kg',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  Slider(
                    value: _maxPrice,
                    min: 0,
                    max: 20,
                    divisions: 40,
                    label: '${_maxPrice.toStringAsFixed(1)} €',
                    onChanged: (value) {
                      setState(() {
                        _maxPrice = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  if (_isSearching) ...[
                    const Divider(),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_searchResults.length} résultat(s)',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: _resetFilters,
                          child: const Text('Réinitialiser'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_searchResults.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            children: [
                              Icon(
                                IconlyLight.search,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Aucun voyage trouvé',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      ..._searchResults.map((trip) => _buildTripCard(trip)),
                  ],
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _performSearch,
              child: const Text(
                'Rechercher',
                style: TextStyle(fontSize: 16),
              ),
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
                      borderRadius: BorderRadius.circular(12),
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
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(IconlyLight.send, size: 18, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text('${trip.departureCity}, ${trip.departureCountry}'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(IconlyLight.download, size: 18, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text('${trip.arrivalCity}, ${trip.arrivalCountry}'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(IconlyLight.calendar, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    '${trip.departureDate.day}/${trip.departureDate.month}/${trip.departureDate.year}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
