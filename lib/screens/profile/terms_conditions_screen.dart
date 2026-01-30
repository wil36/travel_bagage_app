import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conditions d\'utilisation'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Conditions Générales d\'Utilisation',
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
                title: '1. Acceptation des conditions',
                content: 'En utilisant Travel Bagage, vous acceptez ces conditions d\'utilisation. Si vous n\'acceptez pas ces conditions, veuillez ne pas utiliser notre service.',
              ),

              _buildSection(
                title: '2. Description du service',
                content: 'Travel Bagage est une plateforme qui met en relation des voyageurs disposant d\'espace de bagages avec des personnes souhaitant envoyer des colis. Nous facilitons les échanges mais ne sommes pas responsables des transactions entre utilisateurs.',
              ),

              _buildSection(
                title: '3. Inscription et compte',
                content: 'Pour utiliser nos services, vous devez créer un compte en fournissant des informations exactes et à jour. Vous êtes responsable de la confidentialité de votre compte et de toutes les activités qui s\'y rapportent.',
              ),

              _buildSection(
                title: '4. Responsabilités des utilisateurs',
                content: 'En tant qu\'utilisateur, vous vous engagez à :\n\n• Fournir des informations exactes\n• Ne pas transporter de marchandises illégales ou dangereuses\n• Respecter les lois en vigueur dans les pays de départ et d\'arrivée\n• Être honnête sur le poids et la nature des colis\n• Traiter les autres utilisateurs avec respect',
              ),

              _buildSection(
                title: '5. Paiements et remboursements',
                content: 'Les paiements sont traités de manière sécurisée via notre plateforme. Les fonds sont conservés jusqu\'à confirmation de la livraison. Les remboursements sont possibles en cas de problème avéré, selon notre politique de remboursement.',
              ),

              _buildSection(
                title: '6. Interdictions',
                content: 'Il est strictement interdit de :\n\n• Transporter des substances illégales\n• Falsifier des informations\n• Harceler d\'autres utilisateurs\n• Contourner nos systèmes de sécurité\n• Utiliser le service à des fins commerciales sans autorisation',
              ),

              _buildSection(
                title: '7. Limitation de responsabilité',
                content: 'Travel Bagage agit uniquement comme intermédiaire. Nous ne sommes pas responsables des dommages, pertes ou problèmes survenus lors du transport. Les utilisateurs s\'engagent à assurer leurs colis si nécessaire.',
              ),

              _buildSection(
                title: '8. Modification des conditions',
                content: 'Nous nous réservons le droit de modifier ces conditions à tout moment. Les utilisateurs seront informés des changements importants par email ou notification.',
              ),

              _buildSection(
                title: '9. Résiliation',
                content: 'Nous pouvons suspendre ou résilier votre compte en cas de violation de ces conditions. Vous pouvez également fermer votre compte à tout moment depuis les paramètres.',
              ),

              _buildSection(
                title: '10. Contact',
                content: 'Pour toute question concernant ces conditions, contactez-nous à support@travelbagage.com',
              ),

              const SizedBox(height: 32),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  children: [
                    Icon(IconlyLight.infoSquare, color: Colors.blue[700]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Ces conditions sont susceptibles d\'évoluer. Nous vous recommandons de les consulter régulièrement.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blue[900],
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
