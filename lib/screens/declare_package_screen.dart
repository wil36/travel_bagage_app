import 'package:flutter/material.dart';
import 'package:travel_bagage_app/models/package_model.dart';

class DeclarePackageScreen extends StatefulWidget {
  const DeclarePackageScreen({super.key});

  @override
  State<DeclarePackageScreen> createState() => _DeclarePackageScreenState();
}

class _DeclarePackageScreenState extends State<DeclarePackageScreen> {
  final _formKey = GlobalKey<FormState>();
  final _departureCityController = TextEditingController();
  final _departureCountryController = TextEditingController();
  final _arrivalCityController = TextEditingController();
  final _arrivalCountryController = TextEditingController();
  final _weightController = TextEditingController();
  final _offeredPriceController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _neededByDate;
  String _selectedCategory = 'Documents';

  final List<String> _categories = [
    'Documents',
    'Vêtements',
    'Électronique',
    'Nourriture',
    'Médicaments',
    'Autres',
  ];

  @override
  void dispose() {
    _departureCityController.dispose();
    _departureCountryController.dispose();
    _arrivalCityController.dispose();
    _arrivalCountryController.dispose();
    _weightController.dispose();
    _offeredPriceController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
        _neededByDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_neededByDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez sélectionner une date limite'),
          ),
        );
        return;
      }

      final package = PackageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: 'user456',
        senderName: 'Jane Smith',
        departureCity: _departureCityController.text,
        departureCountry: _departureCountryController.text,
        arrivalCity: _arrivalCityController.text,
        arrivalCountry: _arrivalCountryController.text,
        weight: double.parse(_weightController.text),
        description: _descriptionController.text,
        category: _selectedCategory,
        offeredPrice: double.parse(_offeredPriceController.text),
        neededByDate: _neededByDate!,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Colis déclaré avec succès!'),
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
        title: const Text('Déclarer un colis'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Point de départ',
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
                  prefixIcon: Icon(Icons.location_city),
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
                  prefixIcon: Icon(Icons.flag),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le pays de départ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Destination',
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
                  prefixIcon: Icon(Icons.location_city),
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
                  prefixIcon: Icon(Icons.flag),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le pays d\'arrivée';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Détails du colis',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Catégorie',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(
                  labelText: 'Poids (kg)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.scale),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le poids';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un nombre valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _offeredPriceController,
                decoration: const InputDecoration(
                  labelText: 'Prix proposé (€)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.euro),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le prix proposé';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un nombre valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date limite de livraison',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    _neededByDate == null
                        ? 'Sélectionner une date'
                        : '${_neededByDate!.day}/${_neededByDate!.month}/${_neededByDate!.year}',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description du colis',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez décrire votre colis';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text(
                  'Publier mon annonce',
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
