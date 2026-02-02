import 'package:travel_bagage_app/domain/entities/user.dart';

/// UserModel étend l'entité User et ajoute la sérialisation JSON.
///
/// - L'entité User (domain) = objet métier pur, pas de dépendance externe
/// - Le modèle UserModel (data) = ajoute fromJson/toJson pour API et cache
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.phone,
    super.photoUrl,
    super.rating,
    super.completedTrips,
    super.isVerified,
  });

  /// Crée un UserModel depuis une réponse JSON de l'API
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      photoUrl: json['photoUrl'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      completedTrips: json['completedTrips'] as int? ?? 0,
      isVerified: json['isVerified'] as bool? ?? false,
    );
  }

  /// Convertit en JSON pour l'API ou le cache local
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'rating': rating,
      'completedTrips': completedTrips,
      'isVerified': isVerified,
    };
  }

  /// Crée un UserModel depuis une entité User
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      photoUrl: user.photoUrl,
      rating: user.rating,
      completedTrips: user.completedTrips,
      isVerified: user.isVerified,
    );
  }
}
