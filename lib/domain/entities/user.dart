import 'package:equatable/equatable.dart';

/// User entity - objet métier pur, sans dépendance externe
/// Représente un utilisateur dans le domaine de l'application
class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? photoUrl;
  final double rating;
  final int completedTrips;
  final bool isVerified;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.photoUrl,
    this.rating = 0.0,
    this.completedTrips = 0,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        photoUrl,
        rating,
        completedTrips,
        isVerified,
      ];
}
