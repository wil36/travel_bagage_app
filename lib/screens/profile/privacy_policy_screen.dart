import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Politique de confidentialité'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Politique de Confidentialité',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Dernière mise à jour : ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),

              _buildSection(
                title: '1. Introduction',
                content: 'Chez Travel Bagage, nous prenons très au sérieux la protection de vos données personnelles. Cette politique explique quelles informations nous collectons, comment nous les utilisons et vos droits concernant ces données.',
              ),

              _buildSection(
                title: '2. Données collectées',
                content: 'Nous collectons les informations suivantes :\n\n• Informations d\'identification (nom, email, téléphone)\n• Photos de profil et documents d\'identité (pour la vérification)\n• Informations de voyage et de localisation\n• Historique des transactions\n• Données de communication\n• Données d\'utilisation de l\'application',
              ),

              _buildSection(
                title: '3. Utilisation des données',
                content: 'Vos données sont utilisées pour :\n\n• Fournir et améliorer nos services\n• Faciliter les mises en relation entre utilisateurs\n• Vérifier votre identité\n• Traiter les paiements\n• Vous envoyer des notifications importantes\n• Prévenir la fraude et assurer la sécurité\n• Personnaliser votre expérience',
              ),

              _buildSection(
                title: '4. Partage des données',
                content: 'Nous ne vendons jamais vos données personnelles. Vos informations peuvent être partagées uniquement dans les cas suivants :\n\n• Avec d\'autres utilisateurs pour faciliter les transactions\n• Avec nos prestataires de services (paiement, hébergement)\n• Avec les autorités si requis par la loi\n• Avec votre consentement explicite',
              ),

              _buildSection(
                title: '5. Sécurité des données',
                content: 'Nous mettons en œuvre des mesures de sécurité techniques et organisationnelles pour protéger vos données :\n\n• Chiffrement des données sensibles\n• Accès restreint aux données\n• Surveillance constante de la sécurité\n• Audits de sécurité réguliers',
              ),

              _buildSection(
                title: '6. Vos droits',
                content: 'Conformément au RGPD, vous disposez des droits suivants :\n\n• Droit d\'accès à vos données\n• Droit de rectification\n• Droit à l\'effacement ("droit à l\'oubli")\n• Droit à la portabilité\n• Droit d\'opposition\n• Droit de retirer votre consentement',
              ),

              _buildSection(
                title: '7. Conservation des données',
                content: 'Nous conservons vos données personnelles aussi longtemps que nécessaire pour fournir nos services ou comme requis par la loi. Vous pouvez demander la suppression de votre compte à tout moment.',
              ),

              _buildSection(
                title: '8. Cookies',
                content: 'Nous utilisons des cookies pour améliorer votre expérience. Vous pouvez gérer vos préférences de cookies dans les paramètres de votre navigateur.',
              ),

              _buildSection(
                title: '9. Modifications',
                content: 'Nous pouvons modifier cette politique de confidentialité. Toute modification importante vous sera notifiée par email ou via l\'application.',
              ),

              _buildSection(
                title: '10. Contact',
                content: 'Pour exercer vos droits ou pour toute question concernant vos données personnelles, contactez notre délégué à la protection des données à privacy@travelbagage.com',
              ),

              const SizedBox(height: 32),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.verified_user_outlined, color: Colors.green[700]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Vos données sont protégées et conformes au RGPD',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.green[900],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 100), // Espace pour la navbar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
