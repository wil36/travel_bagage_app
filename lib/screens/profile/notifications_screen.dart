import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _smsNotifications = false;
  
  bool _tripUpdates = true;
  bool _messages = true;
  bool _bookingConfirmations = true;
  bool _promotions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section: Canaux de notification
              const Text(
                'Canaux de notification',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choisissez comment vous souhaitez recevoir les notifications',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),

              _buildNotificationToggle(
                icon: Icons.email_outlined,
                title: 'Email',
                subtitle: 'Recevoir des notifications par email',
                value: _emailNotifications,
                onChanged: (value) {
                  setState(() => _emailNotifications = value);
                },
              ),
              const SizedBox(height: 12),
              _buildNotificationToggle(
                icon: Icons.notifications_outlined,
                title: 'Notifications push',
                subtitle: 'Recevoir des notifications push',
                value: _pushNotifications,
                onChanged: (value) {
                  setState(() => _pushNotifications = value);
                },
              ),
              const SizedBox(height: 12),
              _buildNotificationToggle(
                icon: Icons.sms_outlined,
                title: 'SMS',
                subtitle: 'Recevoir des notifications par SMS',
                value: _smsNotifications,
                onChanged: (value) {
                  setState(() => _smsNotifications = value);
                },
              ),

              const SizedBox(height: 32),

              // Section: Types de notifications
              const Text(
                'Types de notifications',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Gérez les types de notifications que vous souhaitez recevoir',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),

              _buildNotificationToggle(
                icon: Icons.flight_takeoff_rounded,
                title: 'Mises à jour de voyage',
                subtitle: 'Changements et rappels de voyage',
                value: _tripUpdates,
                onChanged: (value) {
                  setState(() => _tripUpdates = value);
                },
              ),
              const SizedBox(height: 12),
              _buildNotificationToggle(
                icon: Icons.chat_bubble_outline_rounded,
                title: 'Messages',
                subtitle: 'Nouveaux messages et réponses',
                value: _messages,
                onChanged: (value) {
                  setState(() => _messages = value);
                },
              ),
              const SizedBox(height: 12),
              _buildNotificationToggle(
                icon: Icons.confirmation_number_outlined,
                title: 'Confirmations de réservation',
                subtitle: 'Confirmations et rappels de réservation',
                value: _bookingConfirmations,
                onChanged: (value) {
                  setState(() => _bookingConfirmations = value);
                },
              ),
              const SizedBox(height: 12),
              _buildNotificationToggle(
                icon: Icons.local_offer_outlined,
                title: 'Promotions et offres',
                subtitle: 'Offres spéciales et réductions',
                value: _promotions,
                onChanged: (value) {
                  setState(() => _promotions = value);
                },
              ),

              const SizedBox(height: 100), // Espace pour la navbar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationToggle({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
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
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(10),
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
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
