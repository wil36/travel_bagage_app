import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class DeclareTripScreen extends StatefulWidget {
  const DeclareTripScreen({super.key});

  @override
  State<DeclareTripScreen> createState() => _DeclareTripScreenState();
}

class _DeclareTripScreenState extends State<DeclareTripScreen> {
  final _formKey = GlobalKey<FormState>();
  final _departureCityController = TextEditingController();
  final _departureCountryController = TextEditingController();
  final _arrivalCityController = TextEditingController();
  final _arrivalCountryController = TextEditingController();
  final _availableWeightController = TextEditingController();
  final _pricePerKgController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _departureDate;
  DateTime? _arrivalDate;

  @override
  void dispose() {
    _departureCityController.dispose();
    _departureCountryController.dispose();
    _arrivalCityController.dispose();
    _arrivalCountryController.dispose();
    _availableWeightController.dispose();
    _pricePerKgController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          _departureDate = picked;
        } else {
          _arrivalDate = picked;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_departureDate == null || _arrivalDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez sélectionner les dates de départ et d\'arrivée'),
          ),
        );
        return;
      }

      // final trip = TripModel(
      //   id: DateTime.now().millisecondsSinceEpoch.toString(),
      //   userId: 'user123',
      //   userName: 'John Doe',
      //   departureCity: _departureCityController.text,
      //   departureCountry: _departureCountryController.text,
      //   arrivalCity: _arrivalCityController.text,
      //   arrivalCountry: _arrivalCountryController.text,
      //   departureDate: _departureDate!,
      //   arrivalDate: _arrivalDate!,
      //   availableWeight: double.parse(_availableWeightController.text),
      //   pricePerKg: double.parse(_pricePerKgController.text),
      //   description: _descriptionController.text,
      // );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Voyage déclaré avec succès!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Déclarer un voyage'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Informations de départ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _departureCityController,
                decoration: const InputDecoration(
                  labelText: 'Ville de départ',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(IconlyLight.location),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la ville de départ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _departureCountryController,
                decoration: const InputDecoration(
                  labelText: 'Pays de départ',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(IconlyLight.discovery),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le pays de départ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => _selectDate(context, true),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date de départ',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(IconlyLight.calendar),
                  ),
                  child: Text(
                    _departureDate == null
                        ? 'Sélectionner une date'
                        : '${_departureDate!.day}/${_departureDate!.month}/${_departureDate!.year}',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Informations d\'arrivée',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _arrivalCityController,
                decoration: const InputDecoration(
                  labelText: 'Ville d\'arrivée',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(IconlyLight.location),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la ville d\'arrivée';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _arrivalCountryController,
                decoration: const InputDecoration(
                  labelText: 'Pays d\'arrivée',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(IconlyLight.discovery),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le pays d\'arrivée';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => _selectDate(context, false),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date d\'arrivée',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(IconlyLight.calendar),
                  ),
                  child: Text(
                    _arrivalDate == null
                        ? 'Sélectionner une date'
                        : '${_arrivalDate!.day}/${_arrivalDate!.month}/${_arrivalDate!.year}',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Détails du voyage',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _availableWeightController,
                decoration: const InputDecoration(
                  labelText: 'Poids disponible (kg)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(IconlyLight.bag2),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le poids disponible';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un nombre valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pricePerKgController,
                decoration: const InputDecoration(
                  labelText: 'Prix par kg (€)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(IconlyLight.wallet),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le prix par kg';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un nombre valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (optionnel)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(IconlyLight.document),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text(
                  'Déclarer mon voyage',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
