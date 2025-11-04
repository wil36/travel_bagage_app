class TripModel {
  final String id;
  final String userId;
  final String userName;
  final String? userPhotoUrl;
  final String departureCity;
  final String departureCountry;
  final String arrivalCity;
  final String arrivalCountry;
  final DateTime departureDate;
  final DateTime arrivalDate;
  final double availableWeight;
  final double pricePerKg;
  final String description;
  final TripStatus status;
  final DateTime createdAt;

  TripModel({
    required this.id,
    required this.userId,
    required this.userName,
    this.userPhotoUrl,
    required this.departureCity,
    required this.departureCountry,
    required this.arrivalCity,
    required this.arrivalCountry,
    required this.departureDate,
    required this.arrivalDate,
    required this.availableWeight,
    required this.pricePerKg,
    required this.description,
    this.status = TripStatus.active,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userPhotoUrl': userPhotoUrl,
      'departureCity': departureCity,
      'departureCountry': departureCountry,
      'arrivalCity': arrivalCity,
      'arrivalCountry': arrivalCountry,
      'departureDate': departureDate.toIso8601String(),
      'arrivalDate': arrivalDate.toIso8601String(),
      'availableWeight': availableWeight,
      'pricePerKg': pricePerKg,
      'description': description,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userPhotoUrl: json['userPhotoUrl'] as String?,
      departureCity: json['departureCity'] as String,
      departureCountry: json['departureCountry'] as String,
      arrivalCity: json['arrivalCity'] as String,
      arrivalCountry: json['arrivalCountry'] as String,
      departureDate: DateTime.parse(json['departureDate'] as String),
      arrivalDate: DateTime.parse(json['arrivalDate'] as String),
      availableWeight: (json['availableWeight'] as num).toDouble(),
      pricePerKg: (json['pricePerKg'] as num).toDouble(),
      description: json['description'] as String,
      status: TripStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TripStatus.active,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

enum TripStatus {
  active,
  completed,
  cancelled,
}
