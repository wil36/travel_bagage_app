import 'package:flutter/material.dart';

class IdentityVerificationScreen extends StatefulWidget {
  const IdentityVerificationScreen({super.key});

  @override
  State<IdentityVerificationScreen> createState() => _IdentityVerificationScreenState();
}

class _IdentityVerificationScreenState extends State<IdentityVerificationScreen> {
  bool _isVerified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vérification d\'identité'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Statut de vérification
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _isVerified ? Colors.green[50] : Colors.orange[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isVerified ? Colors.green[200]! : Colors.orange[200]!,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _isVerified ? Icons.verified : Icons.warning_rounded,
                      color: _isVerified ? Colors.green : Colors.orange,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isVerified ? 'Identité vérifiée' : 'Identité non vérifiée',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _isVerified ? Colors.green[900] : Colors.orange[900],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _isVerified
                                ? 'Votre identité a été vérifiée avec succès'
                                : 'Vérifiez votre identité pour accéder à toutes les fonctionnalités',
                            style: TextStyle(
                              fontSize: 13,
                              color: _isVerified ? Colors.green[700] : Colors.orange[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Pourquoi vérifier
              const Text(
                'Pourquoi vérifier votre identité ?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildBenefitItem(
                icon: Icons.security_rounded,
                title: 'Sécurité renforcée',
                description: 'Protégez votre compte et vos transactions',
              ),
              const SizedBox(height: 12),
              _buildBenefitItem(
                icon: Icons.star_rounded,
                title: 'Confiance accrue',
                description: 'Les utilisateurs vous feront plus confiance',
              ),
              const SizedBox(height: 12),
              _buildBenefitItem(
                icon: Icons.workspace_premium_rounded,
                title: 'Accès complet',
                description: 'Débloquez toutes les fonctionnalités premium',
              ),

              const SizedBox(height: 32),

              // Documents requis
              const Text(
                'Documents requis',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildDocumentItem(
                icon: Icons.badge_outlined,
                title: 'Pièce d\'identité',
                description: 'CNI, Passeport ou Permis de conduire',
                isUploaded: false,
              ),
              const SizedBox(height: 12),
              _buildDocumentItem(
                icon: Icons.person_pin_outlined,
                title: 'Selfie avec votre pièce',
                description: 'Pour confirmer votre identité',
                isUploaded: false,
              ),

              const SizedBox(height: 32),

              // Bouton de vérification
              if (!_isVerified)
                ElevatedButton(
                  onPressed: () {
                    _startVerification();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Commencer la vérification',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

              const SizedBox(height: 100), // Espace pour la navbar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.blue[700], size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentItem({
    required IconData icon,
    required String title,
    required String description,
    required bool isUploaded,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isUploaded ? Colors.green[50] : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isUploaded ? Colors.green : Colors.grey[600],
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isUploaded ? Icons.check_circle : Icons.upload_file_rounded,
            color: isUploaded ? Colors.green : Colors.grey[400],
          ),
        ],
      ),
    );
  }

  void _startVerification() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              const Icon(
                Icons.upload_file_rounded,
                size: 60,
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              const Text(
                'Télécharger vos documents',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Cette fonctionnalité sera bientôt disponible',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Fermer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
