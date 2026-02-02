enum PackageStatus {
  pending,
  inTransit,
  delivered,
  cancelled,
}

class PackageModel {
  final String id;
  final String senderId;
  final String senderName;
  final String departureCity;
  final String departureCountry;
  final String arrivalCity;
  final String arrivalCountry;
  final DateTime neededByDate;
  final double weight;
  final double offeredPrice;
  final String description;
  final String category;
  final PackageStatus status;

  PackageModel({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.departureCity,
    required this.departureCountry,
    required this.arrivalCity,
    required this.arrivalCountry,
    required this.neededByDate,
    required this.weight,
    required this.offeredPrice,
    required this.description,
    required this.category,
    this.status = PackageStatus.pending,
  });

  // Getters pour compatibilité avec l'ancien code
  String get userId => senderId;
  String get userName => senderName;
  DateTime get preferredDate => neededByDate;
}
