import 'package:flutter/material.dart';
import 'package:travel_bagage_app/models/trip_model.dart';
import 'package:travel_bagage_app/screens/trip_details_screen.dart';
import 'package:travel_bagage_app/screens/user_profile_screen.dart';

class SearchTripsScreen extends StatefulWidget {
  const SearchTripsScreen({super.key});

  @override
  State<SearchTripsScreen> createState() => _SearchTripsScreenState();
}

class _SearchTripsScreenState extends State<SearchTripsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _departureCityController = TextEditingController();
  final _arrivalCityController = TextEditingController();
  
  DateTime? _selectedDate;
  double _maxPrice = 10.0;
  double _minWeight = 1.0;
  
  List<TripModel> _searchResults = [];
  bool _hasSearched = false;

  @override
  void dispose() {
    _departureCityController.dispose();
    _arrivalCityController.dispose();
    super.dispose();
  }

  void _searchTrips() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implémenter la recherche réelle
      // Pour l'instant, on retourne des résultats factices
      setState(() {
        _hasSearched = true;
        _searchResults = [
          TripModel(
            id: '1',
            userId: 'user1',
            userName: 'Jean Dupont',
            departureCity: _departureCityController.text.isNotEmpty 
                ? _departureCityController.text 
                : 'Paris',
            departureCountry: 'France',
            arrivalCity: _arrivalCityController.text.isNotEmpty 
                ? _arrivalCityController.text 
                : 'Dakar',
            arrivalCountry: 'Sénégal',
            departureDate: _selectedDate ?? DateTime.now().add(const Duration(days: 15)),
            arrivalDate: _selectedDate ?? DateTime.now().add(const Duration(days: 16)),
            availableWeight: 10.0,
            pricePerKg: 5.0,
            description: 'Voyage professionnel',
          ),
          TripModel(
            id: '2',
            userId: 'user2',
            userName: 'Marie Martin',
            departureCity: _departureCityController.text.isNotEmpty 
                ? _departureCityController.text 
                : 'Lyon',
            departureCountry: 'France',
            arrivalCity: _arrivalCityController.text.isNotEmpty 
                ? _arrivalCityController.text 
                : 'Abidjan',
            arrivalCountry: 'Côte d\'Ivoire',
            departureDate: _selectedDate ?? DateTime.now().add(const Duration(days: 20)),
            arrivalDate: _selectedDate ?? DateTime.now().add(const Duration(days: 21)),
            availableWeight: 15.0,
            pricePerKg: 4.5,
            description: 'Retour au pays',
          ),
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rechercher un voyage'),
      ),
      body: Column(
        children: [
          // Formulaire de recherche
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Ville de départ
                      const Text(
                        'Ville de départ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _departureCityController,
                        decoration: const InputDecoration(
                          hintText: 'Ex: Paris, Lyon...',
                          prefixIcon: Icon(Icons.flight_takeoff_rounded),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer une ville de départ';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      // Ville d'arrivée
                      const Text(
                        'Ville d\'arrivée',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _arrivalCityController,
                        decoration: const InputDecoration(
                          hintText: 'Ex: Dakar, Abidjan...',
                          prefixIcon: Icon(Icons.flight_land_rounded),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer une ville d\'arrivée';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      // Date de départ
                      const Text(
                        'Date de départ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                          );
                          if (date != null) {
                            setState(() => _selectedDate = date);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today_rounded, color: Colors.grey[600]),
                              const SizedBox(width: 16),
                              Text(
                                _selectedDate == null
                                    ? 'Sélectionner une date'
                                    : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: _selectedDate == null ? Colors.grey[600] : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Poids minimum
                      const Text(
                        'Poids minimum disponible',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Slider(
                              value: _minWeight,
                              min: 1,
                              max: 30,
                              divisions: 29,
                              label: '${_minWeight.toInt()} kg',
                              onChanged: (value) {
                                setState(() => _minWeight = value);
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${_minWeight.toInt()} kg',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[700],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Prix maximum par kg
                      const Text(
                        'Prix maximum par kg',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Slider(
                              value: _maxPrice,
                              min: 1,
                              max: 20,
                              divisions: 19,
                              label: '${_maxPrice.toInt()} €',
                              onChanged: (value) {
                                setState(() => _maxPrice = value);
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${_maxPrice.toInt()} €',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Bouton Rechercher (juste en dessous du formulaire)
                      ElevatedButton(
                        onPressed: _searchTrips,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_rounded),
                            SizedBox(width: 8),
                            Text(
                              'Rechercher',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Résultats de recherche
                      if (_hasSearched) ...[
                        Divider(color: Colors.grey[300], height: 32),
                        Text(
                          _searchResults.isEmpty
                              ? 'Aucun voyage trouvé'
                              : '${_searchResults.length} voyage(s) trouvé(s)',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (_searchResults.isNotEmpty)
                          ..._searchResults.map((trip) => _buildTripCard(trip)),
                      ],

                      const SizedBox(height: 100), // Espace pour la navbar
                    ],
                  ),
                ),
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.flight_takeoff_rounded,
                      color: Colors.blue[700],
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Divider(height: 1, color: Colors.grey[200]),
              ),
              Row(
                children: [
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
                  Icon(
                    Icons.calendar_today_rounded,
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
                            Icons.work_outline_rounded,
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
}
