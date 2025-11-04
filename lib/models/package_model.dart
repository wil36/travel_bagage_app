class PackageModel {
  final String id;
  final String senderId;
  final String senderName;
  final String? senderPhotoUrl;
  final String? recipientId;
  final String departureCity;
  final String departureCountry;
  final String arrivalCity;
  final String arrivalCountry;
  final double weight;
  final String description;
  final String category;
  final double offeredPrice;
  final DateTime neededByDate;
  final PackageStatus status;
  final DateTime createdAt;

  PackageModel({
    required this.id,
    required this.senderId,
    required this.senderName,
    this.senderPhotoUrl,
    this.recipientId,
    required this.departureCity,
    required this.departureCountry,
    required this.arrivalCity,
    required this.arrivalCountry,
    required this.weight,
    required this.description,
    required this.category,
    required this.offeredPrice,
    required this.neededByDate,
    this.status = PackageStatus.pending,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'senderPhotoUrl': senderPhotoUrl,
      'recipientId': recipientId,
      'departureCity': departureCity,
      'departureCountry': departureCountry,
      'arrivalCity': arrivalCity,
      'arrivalCountry': arrivalCountry,
      'weight': weight,
      'description': description,
      'category': category,
      'offeredPrice': offeredPrice,
      'neededByDate': neededByDate.toIso8601String(),
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      senderPhotoUrl: json['senderPhotoUrl'] as String?,
      recipientId: json['recipientId'] as String?,
      departureCity: json['departureCity'] as String,
      departureCountry: json['departureCountry'] as String,
      arrivalCity: json['arrivalCity'] as String,
      arrivalCountry: json['arrivalCountry'] as String,
      weight: (json['weight'] as num).toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      offeredPrice: (json['offeredPrice'] as num).toDouble(),
      neededByDate: DateTime.parse(json['neededByDate'] as String),
      status: PackageStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => PackageStatus.pending,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

enum PackageStatus {
  pending,
  matched,
  inTransit,
  delivered,
  cancelled,
}
