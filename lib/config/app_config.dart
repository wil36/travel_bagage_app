/// Configuration de l'application
/// Contient les constantes et paramètres globaux
class AppConfig {
  // Empêcher l'instanciation
  AppConfig._();

  // Informations de contact support
  static const String supportEmail = 'support@travelbagage.com';
  static const String supportPhone = '+33123456789';
  static const String whatsappNumber = '33123456789'; // Sans le +

  // URLs
  static const String whatsappBaseUrl = 'https://wa.me/';

  // Messages par défaut
  static const String whatsappDefaultMessage =
      'Bonjour, j\'ai besoin d\'aide avec l\'application TravelBagage.';
}
