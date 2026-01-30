import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aide et support'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section: Contact rapide
              const Text(
                'Nous contacter',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              _buildContactCard(
                icon: IconlyLight.message,
                title: 'Email',
                subtitle: 'support@travelbagage.com',
                color: Colors.blue,
                onTap: () {
                  // TODO: Ouvrir l'app email
                },
              ),
              const SizedBox(height: 12),
              _buildContactCard(
                icon: IconlyLight.call,
                title: 'Téléphone',
                subtitle: '+33 1 23 45 67 89',
                color: Colors.green,
                onTap: () {
                  // TODO: Ouvrir le téléphone
                },
              ),
              const SizedBox(height: 12),
              _buildContactCard(
                icon: IconlyLight.chat,
                title: 'Chat en direct',
                subtitle: 'Discutez avec un agent',
                color: Colors.purple,
                onTap: () {
                  // TODO: Ouvrir le chat
                },
              ),

              const SizedBox(height: 32),

              // Section: FAQ
              const Text(
                'Questions fréquentes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              _buildFAQItem(
                question: 'Comment publier un voyage ?',
                answer: 'Pour publier un voyage, cliquez sur le bouton "+" dans la barre de navigation, puis remplissez les informations de votre voyage (départ, arrivée, dates, poids disponible, etc.).',
              ),
              const SizedBox(height: 12),
              _buildFAQItem(
                question: 'Comment réserver un voyage ?',
                answer: 'Parcourez les voyages disponibles, sélectionnez celui qui vous convient, puis cliquez sur "Réserver". Vous pourrez ensuite discuter avec le voyageur pour finaliser les détails.',
              ),
              const SizedBox(height: 12),
              _buildFAQItem(
                question: 'Comment vérifier mon identité ?',
                answer: 'Rendez-vous dans "Profil" > "Vérification d\'identité" et suivez les instructions pour télécharger vos documents. La vérification prend généralement 24-48 heures.',
              ),
              const SizedBox(height: 12),
              _buildFAQItem(
                question: 'Comment sont gérés les paiements ?',
                answer: 'Les paiements sont sécurisés via notre plateforme. L\'argent est retenu jusqu\'à la confirmation de la livraison par le destinataire. En cas de problème, vous êtes protégé.',
              ),
              const SizedBox(height: 12),
              _buildFAQItem(
                question: 'Que faire en cas de problème ?',
                answer: 'Contactez immédiatement notre support via email, téléphone ou chat. Notre équipe est disponible 7j/7 pour vous aider à résoudre tout problème.',
              ),

              const SizedBox(height: 32),

              // Section: Ressources
              const Text(
                'Ressources utiles',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              _buildResourceItem(
                icon: IconlyLight.paper,
                title: 'Guide d\'utilisation',
                onTap: () {
                  // TODO: Ouvrir le guide
                },
              ),
              const SizedBox(height: 12),
              _buildResourceItem(
                icon: IconlyLight.video,
                title: 'Tutoriels vidéo',
                onTap: () {
                  // TODO: Ouvrir les tutoriels
                },
              ),
              const SizedBox(height: 12),
              _buildResourceItem(
                icon: IconlyLight.user3,
                title: 'Communauté',
                onTap: () {
                  // TODO: Ouvrir la communauté
                },
              ),

              const SizedBox(height: 100), // Espace pour la navbar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(IconlyLight.arrowRight2, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem({
    required String question,
    required String answer,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Theme(
        data: ThemeData().copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          title: Text(
            question,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.grey[700], size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(IconlyLight.arrowRight2, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
