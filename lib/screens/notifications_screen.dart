import 'package:flutter/material.dart';
import 'package:travel_bagage_app/screens/notification_detail_screen.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final String type; // 'message', 'trip', 'package', 'system'
  final String? relatedId;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.isRead,
    required this.type,
    this.relatedId,
  });
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<NotificationModel> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  void _loadNotifications() {
    // Données d'exemple - à remplacer par de vraies données
    setState(() {
      _notifications.addAll([
        NotificationModel(
          id: '1',
          title: 'Nouveau message',
          message: 'Jean Dupont vous a envoyé un message concernant votre voyage Paris-Dakar',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          isRead: false,
          type: 'message',
          relatedId: 'user1',
        ),
        NotificationModel(
          id: '2',
          title: 'Voyage confirmé',
          message: 'Votre voyage Paris-Dakar du 15 mai a été confirmé',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          isRead: false,
          type: 'trip',
          relatedId: 'trip1',
        ),
        NotificationModel(
          id: '3',
          title: 'Demande de colis',
          message: 'Marie Kouassi souhaite utiliser votre voyage pour transporter un colis de 5kg',
          timestamp: DateTime.now().subtract(const Duration(hours: 5)),
          isRead: true,
          type: 'package',
          relatedId: 'package1',
        ),
        NotificationModel(
          id: '4',
          title: 'Paiement reçu',
          message: 'Vous avez reçu un paiement de 40€ pour le transport de colis',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          isRead: true,
          type: 'system',
        ),
        NotificationModel(
          id: '5',
          title: 'Nouveau message',
          message: 'Ahmed Diallo a répondu à votre message',
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
          isRead: true,
          type: 'message',
          relatedId: 'user2',
        ),
        NotificationModel(
          id: '6',
          title: 'Évaluation reçue',
          message: 'Sophie Bernard vous a laissé une évaluation 5 étoiles',
          timestamp: DateTime.now().subtract(const Duration(days: 3)),
          isRead: true,
          type: 'system',
        ),
      ]);
    });
  }

  void _markAsRead(String notificationId) {
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1 && !_notifications[index].isRead) {
        _notifications[index] = NotificationModel(
          id: _notifications[index].id,
          title: _notifications[index].title,
          message: _notifications[index].message,
          timestamp: _notifications[index].timestamp,
          isRead: true,
          type: _notifications[index].type,
          relatedId: _notifications[index].relatedId,
        );
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      _notifications.clear();
      _notifications.addAll(
        _notifications.map((n) => NotificationModel(
          id: n.id,
          title: n.title,
          message: n.message,
          timestamp: n.timestamp,
          isRead: true,
          type: n.type,
          relatedId: n.relatedId,
        )),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Toutes les notifications ont été marquées comme lues'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _deleteNotification(String notificationId) {
    setState(() {
      _notifications.removeWhere((n) => n.id == notificationId);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notification supprimée'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notifications.where((n) => !n.isRead).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text('Tout marquer comme lu'),
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationCard(_notifications[index]);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Aucune notification',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vous serez notifié ici pour les nouveaux messages,\nvoyages et mises à jour',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(NotificationModel notification) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 28,
        ),
      ),
      onDismissed: (direction) {
        _deleteNotification(notification.id);
      },
      child: InkWell(
        onTap: () {
          _markAsRead(notification.id);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationDetailScreen(
                notification: notification,
              ),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: notification.isRead
                ? Colors.white
                : Colors.blue.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: notification.isRead
                  ? Colors.grey[200]!
                  : Colors.blue.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icône de notification
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _getNotificationIconColor(notification.type)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _getNotificationIcon(notification.type),
                  color: _getNotificationIconColor(notification.type),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),

              // Contenu de la notification
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: notification.isRead
                                  ? FontWeight.w600
                                  : FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.message,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatTimestamp(notification.timestamp),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'message':
        return Icons.chat_bubble_rounded;
      case 'trip':
        return Icons.flight_takeoff_rounded;
      case 'package':
        return Icons.inventory_2_rounded;
      case 'system':
        return Icons.info_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }

  Color _getNotificationIconColor(String type) {
    switch (type) {
      case 'message':
        return Colors.blue;
      case 'trip':
        return Colors.green;
      case 'package':
        return Colors.orange;
      case 'system':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'À l\'instant';
    } else if (difference.inMinutes < 60) {
      return 'Il y a ${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return 'Il y a ${difference.inHours}h';
    } else if (difference.inDays == 1) {
      return 'Hier';
    } else if (difference.inDays < 7) {
      return 'Il y a ${difference.inDays} jours';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}
